import 'package:flutter/material.dart';

import '../../core/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/common.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              'Hesap oluştur',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, letterSpacing: -0.6),
            ),
            const SizedBox(height: 24),
            const FieldLabel('Görünen ad'),
            const TextField(decoration: InputDecoration(hintText: 'Uygulamada görünecek adın')),
            const SizedBox(height: 14),
            const FieldLabel('E-posta'),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'ornek@mail.com'),
            ),
            const SizedBox(height: 14),
            const FieldLabel('Şifre'),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'En az 8 karakter'),
            ),
            const SizedBox(height: 14),
            const FieldLabel('Şifre tekrar'),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Şifreni tekrar yaz'),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => _openApp(context),
              child: const Text('Kayıt ol'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Zaten hesabın var mı?', style: TextStyle(color: AppColors.muted)),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
                  child: const Text('Giriş yap'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
