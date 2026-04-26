package com.lrittes.record_summary.channel

import android.content.Context
import android.telephony.PhoneStateListener
import android.telephony.TelephonyManager
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class CallStateChannel(private val context: Context) :
    EventChannel.StreamHandler, CallEventListener {

    companion object {
        const val EVENT_CHANNEL = "com.lrittes.record_summary/call_events"
        const val METHOD_CHANNEL = "com.lrittes.record_summary/call_commands"
    }

    private var eventSink: EventChannel.EventSink? = null
    private val telephonyManager =
        context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

    private val phoneStateListener = object : PhoneStateListener() {
        @Suppress("OVERRIDE_DEPRECATION")
        override fun onCallStateChanged(state: Int, phoneNumber: String?) {
            when (state) {
                TelephonyManager.CALL_STATE_OFFHOOK ->
                    emitEvent(mapOf("type" to "gsm_started"))
                TelephonyManager.CALL_STATE_IDLE ->
                    emitEvent(mapOf("type" to "gsm_ended"))
            }
        }
    }

    fun register() {
        CallEventBus.listener = this
        @Suppress("DEPRECATION")
        telephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_CALL_STATE)
    }

    fun unregister() {
        CallEventBus.listener = null
        @Suppress("DEPRECATION")
        telephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_NONE)
    }

    // EventChannel.StreamHandler
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    // CallEventListener (WhatsApp via AccessibilityService)
    override fun onCallStarted(isVideo: Boolean) {
        emitEvent(mapOf(
            "type" to if (isVideo) "whatsapp_video_started" else "whatsapp_voice_started",
        ))
    }

    override fun onCallEnded() {
        emitEvent(mapOf("type" to "whatsapp_ended"))
    }

    private fun emitEvent(event: Map<String, Any>) {
        eventSink?.success(event)
    }
}