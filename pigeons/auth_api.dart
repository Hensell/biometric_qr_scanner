import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeon/auth_api.dart',
  dartOptions: DartOptions(),
  kotlinOut:
      'android/app/src/main/kotlin/dev/hensell/biometric_qr_scanner/AuthApi.kt',
  kotlinOptions: KotlinOptions(),
  dartPackageName: 'biometric_qr_scanner',
))
@HostApi()
abstract class AuthApi {
  /// Intenta autenticar usando biometría.
  @async
  bool authenticateWithBiometrics();

  /// Verifica si el dispositivo soporta biometría.
  @async
  bool isBiometricAvailable();

  /// Guarda un PIN de forma segura.
  @async
  bool savePin(String pin);

  /// Verifica si hay un PIN guardado.
  @async
  bool isPinSet();

  /// Compara el PIN ingresado con el guardado.
  @async
  bool validatePin(String pin);
}
