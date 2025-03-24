import 'package:biometric_qr_scanner/app/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:biometric_qr_scanner/app/feature/auth/domain/repositories/auth_repository.dart';
import 'package:biometric_qr_scanner/app/feature/qr_list/data/repositories/qr_list_repository_impl.dart';
import 'package:biometric_qr_scanner/app/feature/qr_list/domain/repositories/qr_list_repository.dart';
import 'package:biometric_qr_scanner/app/feature/qr_scanner/data/repositories/qr_scanner_repository_impl.dart';
import 'package:biometric_qr_scanner/app/feature/qr_scanner/domain/repositories/qr_scanner_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DependencyInjection extends StatelessWidget {
  const DependencyInjection({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider<QrScannerRepository>(
          create: (context) => QrScannerRepositoryImpl()),
      RepositoryProvider<QrListRepository>(
          create: (context) => QrListRepositoryImpl()),
      RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl()),
    ], child: child);
  }
}
