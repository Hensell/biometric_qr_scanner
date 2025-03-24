import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:biometric_qr_scanner/app/feature/qr_list/domain/repositories/qr_list_repository.dart';

part 'qr_list_state.dart';

class QrListCubit extends Cubit<QrListState> {
  final QrListRepository _repository;

  QrListCubit(this._repository) : super(QrListInitial());

  Future<void> loadCodes() async {
    emit(QrListLoading());
    try {
      final codes = await _repository.getScannedCodes();
      emit(QrListLoaded(codes));
    } catch (e) {
      emit(QrListError("Error al cargar los códigos: ${e.toString()}"));
    }
  }

  Future<void> deleteCode(int id) async {
    try {
      await _repository.deleteCode(id);
      emit(QrDeleteSuccess());
      await loadCodes(); // refrescar después de eliminar
    } catch (e) {
      emit(QrDeleteError("Error al eliminar código: ${e.toString()}"));
    }
  }
}
