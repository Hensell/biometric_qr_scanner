import 'package:biometric_qr_scanner/app/feature/auth/domain/repositories/auth_repository.dart';
import 'package:biometric_qr_scanner/app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:biometric_qr_scanner/app/feature/auth/presentation/view/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(context.read<AuthRepository>())
        ..checkBiometricAvailability(),
      child: AuthView(),
    );
  }
}
