import 'package:flutter/material.dart';

import '../../core/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/common.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _openApp(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          children: [
            const Text(
              'Tekrar hoş geldin',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, letterSpacing: -0.6),
            ),
            const SizedBox(height: 6),
            const Text(
              'Hesabına giriş yap.',
              style: TextStyle(fontSize: 16, color: AppColors.muted),
            ),
            const SizedBox(height: 28),
            const FieldLabel('E-posta'),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'ornek@mail.com'),
            ),
            const SizedBox(height: 16),
            const FieldLabel('Şifre'),
            const TextField(obscureText: true),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => _openApp(context),
              child: const Text('Giriş yap'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Hesabın yok mu?', style: TextStyle(color: AppColors.muted)),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.register),
                  child: const Text('Kayıt ol'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
