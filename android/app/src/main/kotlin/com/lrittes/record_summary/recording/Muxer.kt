package com.lrittes.record_summary.recording

import android.media.MediaCodec
import android.media.MediaCodecInfo
import android.media.MediaFormat
import android.media.MediaMuxer
import java.io.File
import java.io.FileInputStream
import java.nio.ByteBuffer

object Muxer {

    fun muxToStereoM4a(
        uplinkPcm: File,
        downlinkPcm: File,
        outputM4a: File,
        sampleRate: Int,
    ) {
        val format = MediaFormat.createAudioFormat(MediaFormat.MIMETYPE_AUDIO_AAC, sampleRate, 2)
        format.setInteger(MediaFormat.KEY_BIT_RATE, 64000)
        format.setInteger(
            MediaFormat.KEY_AAC_PROFILE,
            MediaCodecInfo.CodecProfileLevel.AACObjectLC,
        )

        val codec = MediaCodec.createEncoderByType(MediaFormat.MIMETYPE_AUDIO_AAC)
        codec.configure(format, null, null, MediaCodec.CONFIGURE_FLAG_ENCODE)
        codec.start()

        val muxer = MediaMuxer(outputM4a.absolutePath, MediaMuxer.OutputFormat.MUXER_OUTPUT_MPEG_4)
        var trackIndex = -1
        var muxerStarted = false

        val uplinkSamples = readPcm(uplinkPcm)
        val downlinkSamples = readPcm(downlinkPcm)
        val stereoSamples = interleave(uplinkSamples, downlinkSamples)

        val chunkSize = 2048
        var offset = 0
        val bufferInfo = MediaCodec.BufferInfo()

        while (offset <= stereoSamples.size) {
            val isEndOfStream = offset >= stereoSamples.size

            if (!isEndOfStream) {
                val inputIndex = codec.dequeueInputBuffer(10000)
                if (inputIndex >= 0) {
                    val inputBuffer = codec.getInputBuffer(inputIndex)!!
                    inputBuffer.clear()
                    val remaining = minOf(chunkSize, stereoSamples.size - offset)
                    inputBuffer.put(stereoSamples, offset, remaining)
                    codec.queueInputBuffer(inputIndex, 0, remaining, 0, 0)
                    offset += remaining
                }
            } else {
                val inputIndex = codec.dequeueInputBuffer(10000)
                if (inputIndex >= 0) {
                    codec.queueInputBuffer(
                        inputIndex, 0, 0, 0,
                        MediaCodec.BUFFER_FLAG_END_OF_STREAM,
                    )
                }
            }

            var outputIndex = codec.dequeueOutputBuffer(bufferInfo, 10000)
            while (outputIndex >= 0) {
                if (bufferInfo.flags and MediaCodec.BUFFER_FLAG_CODEC_CONFIG != 0) {
                    val newFormat = codec.outputFormat
                    trackIndex = muxer.addTrack(newFormat)
                    muxer.start()
                    muxerStarted = true
                } else if (muxerStarted) {
                    val outputBuffer = codec.getOutputBuffer(outputIndex)!!
                    muxer.writeSampleData(trackIndex, outputBuffer, bufferInfo)
                }
                codec.releaseOutputBuffer(outputIndex, false)
                if (bufferInfo.flags and MediaCodec.BUFFER_FLAG_END_OF_STREAM != 0) break
                outputIndex = codec.dequeueOutputBuffer(bufferInfo, 0)
            }

            if (bufferInfo.flags and MediaCodec.BUFFER_FLAG_END_OF_STREAM != 0) break
        }

        codec.stop()
        codec.release()
        muxer.stop()
        muxer.release()

        uplinkPcm.delete()
        downlinkPcm.delete()
    }

    private fun readPcm(file: File): ByteArray {
        if (!file.exists()) return ByteArray(0)
        return FileInputStream(file).use { it.readBytes() }
    }

    private fun interleave(uplink: ByteArray, downlink: ByteArray): ByteArray {
        val maxLen = maxOf(uplink.size, downlink.size)
        // pad shorter channel with silence
        val up = uplink.copyOf(maxLen)
        val down = downlink.copyOf(maxLen)
        val stereo = ByteArray(maxLen * 2)
        var i = 0
        while (i < maxLen) {
            // left channel (uplink)
            stereo[i * 2] = up[i]
            stereo[i * 2 + 1] = if (i + 1 < maxLen) up[i + 1] else 0
            // right channel (downlink)
            stereo[i * 2 + 2] = down[i]
            stereo[i * 2 + 3] = if (i + 1 < maxLen) down[i + 1] else 0
            i += 2
        }
        return stereo
    }
}