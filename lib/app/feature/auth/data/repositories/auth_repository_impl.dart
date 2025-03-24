import 'package:biometric_qr_scanner/app/feature/auth/domain/repositories/auth_repository.dart';
import 'package:biometric_qr_scanner/pigeon/auth_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _api;

  AuthRepositoryImpl({AuthApi? api}) : _api = api ?? AuthApi();

  @override
  Future<bool> authenticateWithBiometrics() {
    return _api.authenticateWithBiometrics();
  }

  @override
  Future<bool> isBiometricAvailable() {
    return _api.isBiometricAvailable();
  }

  @override
  Future<bool> savePin(String pin) {
    return _api.savePin(pin);
  }

  @override
  Future<bool> isPinSet() {
    return _api.isPinSet();
  }

  @override
  Future<bool> validatePin(String pin) {
    return _api.validatePin(pin);
  }
}
