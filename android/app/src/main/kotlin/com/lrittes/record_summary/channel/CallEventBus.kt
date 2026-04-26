package com.lrittes.record_summary.channel

object CallEventBus {
    var listener: CallEventListener? = null

    fun onCallStarted(isVideo: Boolean) {
        listener?.onCallStarted(isVideo)
    }

    fun onCallEnded() {
        listener?.onCallEnded()
    }
}

interface CallEventListener {
    fun onCallStarted(isVideo: Boolean)
    fun onCallEnded()
}