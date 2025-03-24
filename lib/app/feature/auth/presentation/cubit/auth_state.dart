part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class BiometricAvailable extends AuthState {
  final bool isAvailable;
  BiometricAvailable(this.isAvailable);
}

final class PinAvailability extends AuthState {
  final bool isSet;
  PinAvailability(this.isSet);
}

final class AuthSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  final String reason;
  AuthFailure(this.reason);
}

final class PinSaved extends AuthState {}

final class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
