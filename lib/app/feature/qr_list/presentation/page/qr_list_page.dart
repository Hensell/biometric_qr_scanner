import 'package:biometric_qr_scanner/app/feature/qr_list/domain/repositories/qr_list_repository.dart';
import 'package:biometric_qr_scanner/app/feature/qr_list/presentation/cubit/qr_list_cubit.dart';
import 'package:biometric_qr_scanner/app/feature/qr_list/presentation/view/qr_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QrListPage extends StatelessWidget {
  const QrListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QrListCubit(context.read<QrListRepository>())..loadCodes(),
      child: QrListView(),
    );
  }
}
