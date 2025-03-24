import 'package:biometric_qr_scanner/app/core/global_widget/base_scaffold.dart';
import 'package:flutter/material.dart';

class QrListView extends StatelessWidget {
  const QrListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(body: Text("QR list"), title: "qr_list");
  }
}
