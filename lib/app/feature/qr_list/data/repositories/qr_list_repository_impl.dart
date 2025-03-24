import 'package:flutter/services.dart';
import 'package:biometric_qr_scanner/app/feature/qr_list/domain/repositories/qr_list_repository.dart';

class QrListRepositoryImpl implements QrListRepository {
  static const MethodChannel _methodChannel =
      MethodChannel("dev.hensell.biometric_qr_scanner/db_channel");

  @override
  Future<List<Map<String, dynamic>>> getScannedCodes() async {
    try {
      final List<dynamic> result =
          await _methodChannel.invokeMethod("getCodes");
      return result.cast<Map<dynamic, dynamic>>().map((e) {
        return {
          "id": e["id"],
          "code": e["code"],
          "scannedAt": e["scannedAt"],
        };
      }).toList();
    } on PlatformException catch (e) {
      throw Exception("Error al obtener códigos: ${e.message}");
    }
  }

  @override
  Future<void> deleteCode(int id) async {
    try {
      await _methodChannel.invokeMethod("deleteCode", {"id": id});
    } on PlatformException catch (e) {
      throw Exception("Error al eliminar código: ${e.message}");
    }
  }
}
