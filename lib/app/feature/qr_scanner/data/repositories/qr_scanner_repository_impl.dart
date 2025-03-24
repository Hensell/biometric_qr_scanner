import 'dart:async';
import 'package:flutter/services.dart';
import 'package:biometric_qr_scanner/app/feature/qr_scanner/domain/repositories/qr_scanner_repository.dart';

class QrScannerRepositoryImpl implements QrScannerRepository {
  static const EventChannel _eventChannel =
      EventChannel("dev.hensell.biometric_qr_scanner/qr_stream");

  static const MethodChannel _methodChannel =
      MethodChannel("dev.hensell.biometric_qr_scanner/db_channel");

  @override
  Stream<String> getScannedQrStream() {
    return _eventChannel.receiveBroadcastStream().map((event) {
      return event.toString();
    }).handleError((error) {
      throw Exception("Error al escuchar códigos QR: $error");
    });
  }

  @override
  Future<void> saveScannedCode(String code) async {
    try {
      await _methodChannel.invokeMethod("saveCode", {"code": code});
    } on PlatformException catch (e) {
      throw Exception("Error al guardar el código: ${e.message}");
    }
  }
}
