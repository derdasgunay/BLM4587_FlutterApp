import 'package:flutter/material.dart';

import '../../core/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/rutin_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RutinLogo(size: 128),
                      SizedBox(height: 28),
                      Text(
                        'Rutin Ağı',
                        style: TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1.2,
                          color: AppColors.ink,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Alışkanlık takip asistanı',
                        style: TextStyle(fontSize: 18, color: AppColors.onPrimaryMuted),
                      ),
                    ],
                  ),
                ),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.ink,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                child: const Text('Giriş yap'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: AppColors.ink, width: 2),
                ),
                onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                child: const Text('Kayıt ol'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
