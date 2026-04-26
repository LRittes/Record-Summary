package com.lrittes.record_summary.recording

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.os.IBinder

class RecordingService : Service() {

    companion object {
        const val ACTION_START = "com.lrittes.record_summary.ACTION_START"
        const val ACTION_STOP = "com.lrittes.record_summary.ACTION_STOP"
        const val EXTRA_OUTPUT_PATH = "output_path"
        const val CHANNEL_ID = "recording_channel"
    }

    private val recorder = AudioRecorder()

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_START -> {
                val path = intent.getStringExtra(EXTRA_OUTPUT_PATH) ?: return START_NOT_STICKY
                startForeground(1, buildNotification())
                recorder.start(path)
            }
            ACTION_STOP -> {
                val path = intent.getStringExtra(EXTRA_OUTPUT_PATH) ?: return START_NOT_STICKY
                recorder.stop(path)
                stopForeground(STOP_FOREGROUND_REMOVE)
                stopSelf()
            }
        }
        return START_NOT_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? = null

    private fun buildNotification(): Notification {
        val manager = getSystemService(NotificationManager::class.java)
        if (manager.getNotificationChannel(CHANNEL_ID) == null) {
            manager.createNotificationChannel(
                NotificationChannel(CHANNEL_ID, "Recording", NotificationManager.IMPORTANCE_LOW)
            )
        }
        return Notification.Builder(this, CHANNEL_ID)
            .setContentTitle("Gravando chamada")
            .setSmallIcon(android.R.drawable.ic_btn_speak_now)
            .build()
    }
}