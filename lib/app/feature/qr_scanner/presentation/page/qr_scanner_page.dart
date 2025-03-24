import 'package:biometric_qr_scanner/app/feature/qr_scanner/domain/repositories/qr_scanner_repository.dart';
import 'package:biometric_qr_scanner/app/feature/qr_scanner/presentation/cubit/qr_scanner_cubit.dart';
import 'package:biometric_qr_scanner/app/feature/qr_scanner/presentation/view/qr_scanner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QrScannerPage extends StatelessWidget {
  const QrScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QrScannerCubit(context.read<QrScannerRepository>()),
      child: QrScannerView(),
    );
  }
}
