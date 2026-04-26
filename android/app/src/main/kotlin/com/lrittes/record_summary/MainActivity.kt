package com.lrittes.record_summary

import android.content.Intent
import com.lrittes.record_summary.channel.CallStateChannel
import com.lrittes.record_summary.recording.RecordingService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private lateinit var callStateChannel: CallStateChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        callStateChannel = CallStateChannel(applicationContext)
        callStateChannel.register()

        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CallStateChannel.EVENT_CHANNEL,
        ).setStreamHandler(callStateChannel)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CallStateChannel.METHOD_CHANNEL,
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "startRecording" -> {
                    val path = call.argument<String>("outputPath")
                        ?: return@setMethodCallHandler result.error("INVALID_ARG", "outputPath required", null)
                    startRecordingService(path)
                    result.success(null)
                }
                "stopRecording" -> {
                    val path = call.argument<String>("outputPath")
                        ?: return@setMethodCallHandler result.error("INVALID_ARG", "outputPath required", null)
                    stopRecordingService(path)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onDestroy() {
        callStateChannel.unregister()
        super.onDestroy()
    }

    private fun startRecordingService(outputPath: String) {
        val intent = Intent(this, RecordingService::class.java).apply {
            action = RecordingService.ACTION_START
            putExtra(RecordingService.EXTRA_OUTPUT_PATH, outputPath)
        }
        startForegroundService(intent)
    }

    private fun stopRecordingService(outputPath: String) {
        val intent = Intent(this, RecordingService::class.java).apply {
            action = RecordingService.ACTION_STOP
            putExtra(RecordingService.EXTRA_OUTPUT_PATH, outputPath)
        }
        startService(intent)
    }
}