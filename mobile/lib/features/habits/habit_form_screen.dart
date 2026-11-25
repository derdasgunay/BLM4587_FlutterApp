import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../widgets/common.dart';

/// Şablon: yeni alışkanlık ve düzenleme formu (kaydetme 7. haftada).
class HabitFormScreen extends StatelessWidget {
  const HabitFormScreen({super.key, this.isEditing = false});

  final bool isEditing;

  static const _categories = [
    'Kategorisiz',
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
    final selectedCategory = isEditing ? 'Eğitim' : 'Kategorisiz';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Kapat',
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(isEditing ? 'Alışkanlığı düzenle' : 'Yeni alışkanlık'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              children: [
                const FieldLabel('Ad *'),
                TextFormField(
                  initialValue: isEditing ? '20 dk kitap okuma' : null,
                  decoration: const InputDecoration(hintText: 'Örn. 20 dk kitap okuma'),
                ),
                const SizedBox(height: 20),
                const FieldLabel('Kategori'),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final category in _categories)
                      SelectChip(
                        label: category,
                        selected: category == selectedCategory,
                        onSelected: () {},
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                const FieldLabel('Periyot'),
                SegmentedButton<String>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(value: 'Daily', label: Text('Günlük')),
                    ButtonSegment(value: 'Weekly', label: Text('Haftalık')),
                  ],
                  selected: const {'Daily'},
                  onSelectionChanged: (_) {},
                ),
                const SizedBox(height: 20),
                const FieldLabel('Hedef sayısı'),
                Row(
                  children: [
                    IconButton.filledTonal(
                      tooltip: 'Azalt',
                      onPressed: () {},
                      icon: const Icon(Icons.remove_rounded),
                    ),
                    const SizedBox(
                      width: 52,
                      child: Text(
                        '1',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                    ),
                    IconButton.filledTonal(
                      tooltip: 'Artır',
                      onPressed: () {},
                      icon: const Icon(Icons.add_rounded),
                    ),
                    const SizedBox(width: 12),
                    const Text('Günde 1 kez', style: TextStyle(fontSize: 14, color: AppColors.muted)),
                  ],
                ),
                const SizedBox(height: 20),
                const SectionCard(
                  title: 'Alışkanlık döngüsü',
                  children: [
                    Text(
                      'İsteğe bağlı alanlar.',
                      style: TextStyle(fontSize: 13, color: AppColors.muted),
                    ),
                    SizedBox(height: 12),
                    _LoopField(label: 'İşaret', hint: 'Ne zaman, nerede başlayacaksın?'),
                    _LoopField(label: 'Cazip kıl', hint: 'Bunu keyifli yapan ne olacak?'),
                    _LoopField(label: 'Kolay adım', hint: 'İki dakikada yapılabilecek ilk adım'),
                    _LoopField(label: 'Ödül', hint: 'Bitirince kendine ne vereceksin?'),
                  ],
                ),
                const SizedBox(height: 16),
                Card(
                  child: SwitchListTile(
                    value: true,
                    onChanged: (_) {},
                    title: const Text('Aktif', style: TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: const Text('Pasif alışkanlıklar işaretlenemez.'),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(isEditing ? 'Değişiklikleri kaydet' : 'Kaydet'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoopField extends StatelessWidget {
  const _LoopField({required this.label, required this.hint});

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          TextField(
            decoration: InputDecoration(hintText: hint, fillColor: AppColors.background),
          ),
        ],
      ),
    );
  }
}
