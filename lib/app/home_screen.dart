import 'package:biometric_qr_scanner/app/core/global_widget/base_scaffold.dart';
import 'package:biometric_qr_scanner/app/core/global_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              CustomButton(
                text: "Escanear QR",
                onPress: () => context.go(
                  '/home_screen/qr_scanner',
                ),
              ),
              CustomButton(
                text: "Lista de QR guardados",
                onPress: () => context.go(
                  '/home_screen/qr_list',
                ),
              ),
            ],
          ),
        ),
        title: "Biometric QR scanner");
  }
}
