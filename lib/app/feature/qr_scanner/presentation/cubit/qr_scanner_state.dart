part of 'qr_scanner_cubit.dart';

@immutable
sealed class QrScannerState {}

final class QrScannerInitial extends QrScannerState {}

final class QrScannerLoading extends QrScannerState {}

final class QrScannerListening extends QrScannerState {}

final class QrScannerSuccess extends QrScannerState {
  final String scannedCode;

  QrScannerSuccess(this.scannedCode);
}

final class QrScannerError extends QrScannerState {
  final String message;

  QrScannerError(this.message);
}

final class QrScannerSaving extends QrScannerState {}

final class QrScannerSaved extends QrScannerState {}

final class QrScannerSaveError extends QrScannerState {
  final String message;
  QrScannerSaveError(this.message);
}
