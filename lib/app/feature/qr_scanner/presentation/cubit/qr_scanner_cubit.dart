import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:biometric_qr_scanner/app/feature/qr_scanner/domain/repositories/qr_scanner_repository.dart';

part 'qr_scanner_state.dart';

class QrScannerCubit extends Cubit<QrScannerState> {
  final QrScannerRepository _repository;
  StreamSubscription<String>? _subscription;

  QrScannerCubit(this._repository) : super(QrScannerInitial());

  void startListening() {
    emit(QrScannerListening());

    _subscription = _repository.getScannedQrStream().listen(
      (code) {
        emit(QrScannerSuccess(code));
      },
      onError: (error) {
        emit(QrScannerError(error.toString()));
      },
    );
  }

  Future<void> saveCode(String code) async {
    emit(QrScannerSaving());
    try {
      await _repository.saveScannedCode(code);
      emit(QrScannerSaved());

      emit(QrScannerSuccess(code));
    } catch (e) {
      emit(QrScannerSaveError("Error al guardar: ${e.toString()}"));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
