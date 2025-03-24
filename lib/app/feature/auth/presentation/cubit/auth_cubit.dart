import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:biometric_qr_scanner/app/feature/auth/domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;

  AuthCubit(this._repository) : super(AuthInitial());

  Future<void> checkBiometricAvailability() async {
    emit(AuthLoading());
    try {
      final available = await _repository.isBiometricAvailable();
      emit(BiometricAvailable(available));
    } catch (e) {
      emit(AuthError("Error al verificar biometría: ${e.toString()}"));
    }
  }

  Future<void> authenticate() async {
    emit(AuthLoading());
    try {
      final success = await _repository.authenticateWithBiometrics();
      emit(success ? AuthSuccess() : AuthFailure("Autenticación fallida"));
    } catch (e) {
      emit(AuthError("Error de autenticación: ${e.toString()}"));
    }
  }

  Future<void> savePin(String pin) async {
    emit(AuthLoading());
    try {
      final saved = await _repository.savePin(pin);
      emit(saved ? PinSaved() : AuthError("No se pudo guardar el PIN"));
    } catch (e) {
      emit(AuthError("Error al guardar el PIN: ${e.toString()}"));
    }
  }

  Future<void> checkIfPinIsSet() async {
    emit(AuthLoading());
    try {
      final isSet = await _repository.isPinSet();
      emit(PinAvailability(isSet));
    } catch (e) {
      emit(AuthError("Error al verificar el PIN: ${e.toString()}"));
    }
  }

  Future<void> validatePin(String pin) async {
    emit(AuthLoading());
    try {
      final valid = await _repository.validatePin(pin);
      emit(valid ? AuthSuccess() : AuthFailure("PIN incorrecto"));
    } catch (e) {
      emit(AuthError("Error al validar el PIN: ${e.toString()}"));
    }
  }
}
