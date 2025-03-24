import 'package:biometric_qr_scanner/app/core/global_widget/base_scaffold.dart';
import 'package:biometric_qr_scanner/app/feature/qr_list/presentation/cubit/qr_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QrListView extends StatelessWidget {
  const QrListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Lista de QR's",
      body: BlocBuilder<QrListCubit, QrListState>(
        builder: (context, state) {
          if (state is QrListLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is QrListError) {
            return Center(child: Text("❌ ${state.message}"));
          }

          if (state is QrListLoaded) {
            if (state.codes.isEmpty) {
              return const Center(child: Text("No hay códigos guardados."));
            }

            return ListView.builder(
              itemCount: state.codes.length,
              itemBuilder: (context, index) {
                final codeData = state.codes[index];
                return ListTile(
                  title: Text(codeData["code"] ?? "Código vacío"),
                  subtitle: Text(
                      "ID: ${codeData["id"]} • ${DateTime.fromMillisecondsSinceEpoch(codeData["scannedAt"] ?? 0)}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<QrListCubit>().deleteCode(codeData["id"]);
                    },
                  ),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: codeData["code"]));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Codigo copiado al portapapeles')),
                    );
                  },
                );
              },
            );
          }

          return const Center(child: Text("Presiona para cargar códigos."));
        },
      ),
    );
  }
}
