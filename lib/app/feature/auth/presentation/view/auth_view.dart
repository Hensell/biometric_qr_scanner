import 'package:biometric_qr_scanner/app/core/global_widget/base_scaffold.dart';
import 'package:biometric_qr_scanner/app/core/global_widget/custom_button.dart';
import 'package:biometric_qr_scanner/app/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart'; // 👈 asegúrate de tener esto

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Bienvenido",
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go('/home_screen');
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AuthFailure) {
            return Center(child: Text("❌ Falló: ${state.reason}"));
          }

          if (state is BiometricAvailable) {
            return Center(
                child: CustomButton(
              text: "Ingresar",
              onPress: () => context.read<AuthCubit>().authenticate(),
            ));
          }

          if (state is PinAvailability && state.isSet) {
            return _PinInputForm(
              onSubmit: (pin) {
                context.read<AuthCubit>().validatePin(pin);
              },
            );
          }

          if (state is PinAvailability && !state.isSet) {
            return _PinInputForm(
              onSubmit: (pin) {
                context.read<AuthCubit>().savePin(pin);
              },
              label: "Crear nuevo PIN",
            );
          }

          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthCubit>().checkBiometricAvailability();
              },
              child: const Text("Verificar método de autenticación"),
            ),
          );
        },
      ),
    );
  }
}

class _PinInputForm extends StatefulWidget {
  final void Function(String) onSubmit;
  final String label;

  const _PinInputForm({required this.onSubmit, this.label = "Ingresar PIN"});

  @override
  State<_PinInputForm> createState() => _PinInputFormState();
}

class _PinInputFormState extends State<_PinInputForm> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.label, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            obscureText: true,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "PIN",
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final pin = _controller.text.trim();
              if (pin.length == 4) {
                widget.onSubmit(pin);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("El PIN debe tener 4 dígitos")),
                );
              }
            },
            child: const Text("Confirmar"),
          ),
        ],
      ),
    );
  }
}
