import 'package:biometric_qr_scanner/app/core/global_widget/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () => context.go(
                      '/qr_scanner',
                    ),
                child: Text("QR SCANNER")),
            ElevatedButton(
                onPressed: () => context.go(
                      '/qr_list',
                    ),
                child: Text("QR LIST")),
          ],
        ),
        title: "title");
  }
}
