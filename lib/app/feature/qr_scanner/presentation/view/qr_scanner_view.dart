import 'package:biometric_qr_scanner/app/feature/qr_scanner/presentation/cubit/qr_scanner_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class QrScannerView extends StatefulWidget {
  const QrScannerView({super.key});

  @override
  State<QrScannerView> createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  @override
  void initState() {
    super.initState();
    context.read<QrScannerCubit>().startListening();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: BlocConsumer<QrScannerCubit, QrScannerState>(
        listener: (context, state) {
          if (state is QrScannerSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("✅ Código guardado exitosamente")),
            );
          } else if (state is QrScannerSaveError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("❌ ${state.message}")),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<QrScannerCubit>();

          final cameraView = const AndroidView(
            viewType: 'native-camera-view',
            layoutDirection: TextDirection.ltr,
          );

          final bool isSaving = state is QrScannerSaving;
          final bool canSave = state is QrScannerSuccess;
          final String displayText = switch (state) {
            QrScannerInitial _ => "Iniciando...",
            QrScannerListening _ => "Escaneando...",
            QrScannerSaving _ => "Guardando...",
            QrScannerSaved _ => "¡Código guardado!",
            QrScannerSuccess(:final scannedCode) => scannedCode,
            QrScannerError(:final message) => "Error: $message",
            QrScannerSaveError(:final message) => "Error al guardar: $message",
            _ => "Desconocido",
          };

          final content = Container(
            width: double.infinity,
            color: Colors.black87,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  displayText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                if (isSaving)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: canSave
                        ? () {
                            final scannedCode = (state).scannedCode;
                            cubit.saveCode(scannedCode);
                          }
                        : null,
                    child: const Text("Guardar código"),
                  ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  child: const Text("Volver al inicio"),
                ),
              ],
            ),
          );

          return isPortrait
              ? Column(
                  children: [
                    Flexible(flex: 1, child: cameraView),
                    Flexible(flex: 2, child: content),
                  ],
                )
              : Row(
                  children: [
                    Flexible(flex: 1, child: cameraView),
                    Flexible(flex: 2, child: content),
                  ],
                );
        },
      ),
    );
  }
}
