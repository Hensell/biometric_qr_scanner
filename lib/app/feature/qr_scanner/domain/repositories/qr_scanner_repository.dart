abstract class QrScannerRepository {
  Stream<String> getScannedQrStream();
  Future<void> saveScannedCode(String code);
}
