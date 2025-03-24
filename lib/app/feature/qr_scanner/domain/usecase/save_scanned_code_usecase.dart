import 'package:biometric_qr_scanner/app/feature/qr_scanner/domain/repositories/qr_scanner_repository.dart';

class SaveScannedCodeUseCase {
  final QrScannerRepository repository;

  SaveScannedCodeUseCase(this.repository);

  Future<void> call(String code) {
    return repository.saveScannedCode(code);
  }
}
