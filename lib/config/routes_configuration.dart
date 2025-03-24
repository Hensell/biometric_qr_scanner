import 'package:biometric_qr_scanner/app/feature/auth/presentation/page/auth_page.dart';
import 'package:biometric_qr_scanner/app/feature/qr_list/presentation/page/qr_list_page.dart';
import 'package:biometric_qr_scanner/app/feature/qr_scanner/presentation/page/qr_scanner_page.dart';
import 'package:biometric_qr_scanner/app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter routesConfiguration = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthPage();
      },
    ),
    GoRoute(
      path: '/home_screen',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'qr_scanner',
          builder: (BuildContext context, GoRouterState state) {
            return const QrScannerPage();
          },
        ),
        GoRoute(
          path: 'qr_list',
          builder: (BuildContext context, GoRouterState state) {
            return const QrListPage();
          },
        ),
      ],
    ),
  ],
);
