package dev.hensell.biometric_qr_scanner

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.*
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.flow.filterNotNull

class MainActivity : FlutterActivity() {

    private val scannerFlow = MutableSharedFlow<String?>(replay = 0)
    private val eventChannelName = "dev.hensell.biometric_qr_scanner/qr_stream"
    private var eventSink: EventChannel.EventSink? = null
    private val mainScope = CoroutineScope(Dispatchers.Main + SupervisorJob())

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Registrar el PlatformView de la cámara, pasando el flujo y el ciclo de vida
        flutterEngine?.platformViewsController
            ?.registry
            ?.registerViewFactory(
                "native-camera-view",
                CameraPreviewFactory(scannerFlow, this)
            )

        // Configurar EventChannel para enviar códigos QR a Flutter
        EventChannel(flutterEngine?.dartExecutor?.binaryMessenger, eventChannelName)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                    startSendingScannedCodes()
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                    mainScope.coroutineContext.cancelChildren()
                }
            })
    }

    private fun startSendingScannedCodes() {
        mainScope.launch {
            scannerFlow
                .filterNotNull()
                .collectLatest { qrCode ->
                    eventSink?.success(qrCode)
                }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        mainScope.cancel()
    }
}
