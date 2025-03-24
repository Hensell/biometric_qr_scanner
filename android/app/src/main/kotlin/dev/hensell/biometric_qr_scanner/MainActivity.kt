package dev.hensell.biometric_qr_scanner

import android.Manifest
import android.content.pm.PackageManager
import android.os.Bundle
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import dev.hensell.biometric_qr_scanner.data.local.database.QrDatabase
import dev.hensell.biometric_qr_scanner.data.local.entity.QrEntity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.flow.filterNotNull

class MainActivity : FlutterFragmentActivity() {

    private val scannerFlow = MutableSharedFlow<String?>(replay = 0)
    private val eventChannelName = "dev.hensell.biometric_qr_scanner/qr_stream"
    private val methodChannelName = "dev.hensell.biometric_qr_scanner/db_channel"
    private var eventSink: EventChannel.EventSink? = null
    private val mainScope = CoroutineScope(Dispatchers.Main + SupervisorJob())
    private val CAMERA_PERMISSION_CODE = 1001

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        checkAndRequestCameraPermission()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        AuthApi.setUp(
            flutterEngine.dartExecutor.binaryMessenger,
            MyAuthApiImpl(context = this, activity = this)
        )

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(
                "native-camera-view",
                CameraPreviewFactory(scannerFlow, this)
            )

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, eventChannelName)
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

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannelName)
            .setMethodCallHandler { call, result ->
                val db = QrDatabase.getInstance(this)
                val dao = db.qrDao()

                when (call.method) {
                    "saveCode" -> {
                        val code = call.argument<String>("code")
                        if (code != null) {
                            CoroutineScope(Dispatchers.IO).launch {
                                dao.insert(QrEntity(code = code))
                                withContext(Dispatchers.Main) {
                                    result.success(true)
                                }
                            }
                        } else {
                            result.error("INVALID_ARGUMENT", "Code is null", null)
                        }
                    }

                    "getCodes" -> {
                        CoroutineScope(Dispatchers.IO).launch {
                            val codes = dao.getAll().map {
                                mapOf(
                                    "id" to it.id,
                                    "code" to it.code,
                                    "scannedAt" to it.scannedAt
                                )
                            }
                            withContext(Dispatchers.Main) {
                                result.success(codes)
                            }
                        }
                    }

                    "deleteCode" -> {
                        val id = call.argument<Int>("id")
                        if (id != null) {
                            CoroutineScope(Dispatchers.IO).launch {
                                dao.deleteById(id)
                                withContext(Dispatchers.Main) {
                                    result.success(true)
                                }
                            }
                        } else {
                            result.error("INVALID_ARGUMENT", "ID is null", null)
                        }
                    }

                    else -> result.notImplemented()
                }
            }
    }

    private fun checkAndRequestCameraPermission() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA)
            != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.CAMERA),
                CAMERA_PERMISSION_CODE
            )
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == CAMERA_PERMISSION_CODE) {
            if ((grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED)) {
                // Permiso concedido
            } else {
                // Permiso denegado
            }
        }
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
