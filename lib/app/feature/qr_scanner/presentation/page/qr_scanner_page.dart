import 'package:biometric_qr_scanner/app/feature/qr_scanner/domain/repositories/qr_scanner_repository.dart';
import 'package:biometric_qr_scanner/app/feature/qr_scanner/domain/usecase/save_scanned_code_usecase.dart';
import 'package:biometric_qr_scanner/app/feature/qr_scanner/presentation/cubit/qr_scanner_cubit.dart';
import 'package:biometric_qr_scanner/app/feature/qr_scanner/presentation/view/qr_scanner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QrScannerPage extends StatelessWidget {
  const QrScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<QrScannerRepository>();
    final saveUseCase = SaveScannedCodeUseCase(repository);

    return BlocProvider(
      create: (_) => QrScannerCubit(repository, saveUseCase),
      child: const QrScannerView(),
    );
  }
}
