abstract class AuthRepository {
  /// Verifica si hay biometría disponible en el dispositivo.
  Future<bool> isBiometricAvailable();

  /// Inicia el proceso de autenticación con biometría.
  Future<bool> authenticateWithBiometrics();

  /// Guarda un PIN de forma segura en el dispositivo.
  Future<bool> savePin(String pin);

  /// Verifica si ya existe un PIN guardado.
  Future<bool> isPinSet();

  /// Valida un PIN ingresado por el usuario contra el almacenado.
  Future<bool> validatePin(String pin);
}
