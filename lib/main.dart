import 'package:biometric_qr_scanner/config/dependency_injection.dart';
import 'package:biometric_qr_scanner/config/routes_configuration.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DependencyInjection(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: routesConfiguration,
        title: 'Biometric QR scanner',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.light,
            seedColor: const Color(0xFFAC92A6),
            contrastLevel: 1,
          ),
        ),
      ),
    );
  }
}
