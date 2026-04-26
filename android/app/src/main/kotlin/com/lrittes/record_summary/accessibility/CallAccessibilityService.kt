package com.lrittes.record_summary.accessibility

import android.accessibilityservice.AccessibilityService
import android.view.accessibility.AccessibilityEvent
import com.lrittes.record_summary.channel.CallEventBus

class CallAccessibilityService : AccessibilityService() {

    private var isInCall = false

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        event ?: return
        if (event.packageName == null) return

        val pkg = event.packageName.toString()
        if (pkg != "com.whatsapp" && pkg != "com.whatsapp.w4b") return

        val className = event.className?.toString() ?: return

        val callStarted = CALL_ACTIVITY_CLASSES.any { className.contains(it) }

        when {
            callStarted && !isInCall -> {
                isInCall = true
                CallEventBus.onCallStarted(isVideo = className.contains("Video"))
            }
            !callStarted && isInCall -> {
                isInCall = false
                CallEventBus.onCallEnded()
            }
        }
    }

    override fun onInterrupt() {
        if (isInCall) {
            isInCall = false
            CallEventBus.onCallEnded()
        }
    }

    companion object {
        private val CALL_ACTIVITY_CLASSES = listOf(
            "VoipActivity",
            "VideoCallActivity",
            "InCallActivity",
            "AudioCallActivity",
        )
    }
}