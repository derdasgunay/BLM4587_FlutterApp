import 'package:flutter/material.dart';

import '../../core/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/common.dart';

/// Şablon: örnek kullanıcı bilgileri.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            const Text(
              'Profil',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.5),
            ),
            const SizedBox(height: 16),
            const InfoCard(rows: [
              InfoRow('Görünen ad', 'Derda S. Günay'),
              InfoRow('E-posta', 'ornek@mail.com'),
              InfoRow('Rol', 'Admin', trailing: RoleBadge(label: 'Admin', highlighted: true)),
              InfoRow('Üyelik tarihi', '1 Kasım 2026'),
            ]),
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.ink,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.categories),
              child: const Text('Kategorileri yönet'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              style: OutlinedButton.styleFrom(foregroundColor: AppColors.danger),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              ),
              child: const Text('Çıkış yap'),
            ),
          ],
        ),
      ),
    );
  }
}
