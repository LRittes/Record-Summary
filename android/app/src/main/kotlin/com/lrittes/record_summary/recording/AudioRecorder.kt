package com.lrittes.record_summary.recording

import android.media.AudioFormat
import android.media.AudioRecord
import android.media.MediaRecorder
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import java.io.File
import java.io.FileOutputStream

class AudioRecorder {

    private var uplinkRecord: AudioRecord? = null
    private var downlinkRecord: AudioRecord? = null
    private var recordingJob: Job? = null

    private val sampleRate = 16000
    private val channelConfig = AudioFormat.CHANNEL_IN_MONO
    private val audioFormat = AudioFormat.ENCODING_PCM_16BIT
    private val bufferSize = AudioRecord.getMinBufferSize(sampleRate, channelConfig, audioFormat)

    fun start(outputPath: String) {
        uplinkRecord = AudioRecord(
            MediaRecorder.AudioSource.VOICE_UPLINK,
            sampleRate,
            channelConfig,
            audioFormat,
            bufferSize,
        )
        downlinkRecord = AudioRecord(
            MediaRecorder.AudioSource.VOICE_DOWNLINK,
            sampleRate,
            channelConfig,
            audioFormat,
            bufferSize,
        )

        uplinkRecord?.startRecording()
        downlinkRecord?.startRecording()

        val uplinkFile = File("${outputPath}_uplink.pcm")
        val downlinkFile = File("${outputPath}_downlink.pcm")

        recordingJob = CoroutineScope(Dispatchers.IO).launch {
            val uplinkOut = FileOutputStream(uplinkFile)
            val downlinkOut = FileOutputStream(downlinkFile)
            val buffer = ByteArray(bufferSize)

            try {
                while (uplinkRecord?.recordingState == AudioRecord.RECORDSTATE_RECORDING) {
                    val uplinkRead = uplinkRecord?.read(buffer, 0, bufferSize) ?: 0
                    if (uplinkRead > 0) uplinkOut.write(buffer, 0, uplinkRead)

                    val downlinkRead = downlinkRecord?.read(buffer, 0, bufferSize) ?: 0
                    if (downlinkRead > 0) downlinkOut.write(buffer, 0, downlinkRead)
                }
            } finally {
                uplinkOut.close()
                downlinkOut.close()
            }
        }
    }

    fun stop(outputPath: String) {
        uplinkRecord?.stop()
        downlinkRecord?.stop()
        uplinkRecord?.release()
        downlinkRecord?.release()
        uplinkRecord = null
        downlinkRecord = null
        recordingJob?.cancel()
        recordingJob = null

        Muxer.muxToStereoM4a(
            uplinkPcm = File("${outputPath}_uplink.pcm"),
            downlinkPcm = File("${outputPath}_downlink.pcm"),
            outputM4a = File("$outputPath.m4a"),
            sampleRate = 16000,
        )
    }

    val isRecording: Boolean
        get() = uplinkRecord?.recordingState == AudioRecord.RECORDSTATE_RECORDING
}