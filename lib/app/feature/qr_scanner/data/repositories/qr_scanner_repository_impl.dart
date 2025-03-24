import 'dart:async';
import 'package:biometric_qr_scanner/app/feature/qr_scanner/data/datasource/qr_local_datasource.dart';
import 'package:flutter/services.dart';
import 'package:biometric_qr_scanner/app/feature/qr_scanner/domain/repositories/qr_scanner_repository.dart';

class QrScannerRepositoryImpl implements QrScannerRepository {
  static const EventChannel _eventChannel =
      EventChannel("dev.hensell.biometric_qr_scanner/qr_stream");
  final QrLocalDataSource _localDataSource = QrLocalDataSource();

  @override
  Stream<String> getScannedQrStream() {
    return _eventChannel.receiveBroadcastStream().map((event) {
      return event.toString();
    }).handleError((error) {
      throw Exception("Error al escuchar códigos QR: $error");
    });
  }

  @override
  Future<void> saveScannedCode(String code) {
    return _localDataSource.insertCode(code);
  }
}
