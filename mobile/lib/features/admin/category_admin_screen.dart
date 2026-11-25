import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../widgets/common.dart';

/// Şablon: Admin kategori yönetimi (işlevler 8. haftada).
class CategoryAdminScreen extends StatelessWidget {
  const CategoryAdminScreen({super.key});

  static const _categories = [
    'Sağlık',
    'Spor',
    'Uyku',
    'Eğitim',
    'Dil öğrenme',
    'Üretkenlik',
    'Odaklanma',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriler'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(child: RoleBadge(label: 'Admin', highlighted: true)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
        children: [
          SectionCard(
            title: 'Yeni kategori',
            children: [
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Örn. Meditasyon',
                  fillColor: AppColors.background,
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(onPressed: () {}, child: const Text('Ekle')),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                for (var i = 0; i < _categories.length; i++)
                  Container(
                    constraints: const BoxConstraints(minHeight: 52),
                    padding: const EdgeInsets.only(left: 16, right: 4),
                    decoration: BoxDecoration(
                      border: i > 0
                          ? const Border(top: BorderSide(color: AppColors.divider))
                          : null,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _categories[i],
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(foregroundColor: AppColors.ink),
                          child: const Text('Düzenle'),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(foregroundColor: AppColors.danger),
                          child: const Text('Sil'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
