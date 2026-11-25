import 'package:flutter/material.dart';

import '../../core/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/common.dart';

/// Şablon: örnek bir alışkanlığın detayı.
class HabitDetailScreen extends StatelessWidget {
  const HabitDetailScreen({super.key});

  static const _sampleLogs = [
    (date: '24 Kas', done: true, note: 'Yatmadan önce 25 sayfa'),
    (date: '23 Kas', done: true, note: 'Not yok'),
    (date: '22 Kas', done: true, note: 'Not yok'),
    (date: '17 Kas', done: false, note: 'Sınav haftası, vakit olmadı'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.habitForm, arguments: true),
            style: TextButton.styleFrom(foregroundColor: AppColors.ink),
            child: const Text('Düzenle'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
              children: [
                const Text(
                  '20 dk kitap okuma',
                  style: TextStyle(
                    fontSize: 28,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16),
                const _StreakBanner(streak: 7),
                const SizedBox(height: 16),
                const InfoCard(rows: [
                  InfoRow('Kategori', 'Eğitim'),
                  InfoRow('Periyot', 'Günlük'),
                  InfoRow('Hedef', 'Günde 1 kez'),
                  InfoRow('Durum', 'Aktif'),
                  InfoRow('Oluşturulma', '2 Kasım 2026'),
                ]),
                const SizedBox(height: 16),
                const SectionCard(
                  title: 'Alışkanlık döngüsü',
                  children: [
                    _LoopRow(label: 'İşaret', value: 'Akşam yemeğinden sonra çayımı aldığımda'),
                    _LoopRow(label: 'Cazip kıl', value: 'Sevdiğim köşede, sevdiğim kitapla'),
                    _LoopRow(label: 'Kolay adım', value: 'Sadece bir sayfa okuyarak başla'),
                    _LoopRow(
                      label: 'Ödül',
                      value: 'Okuduğum bir cümleyi deftere yazmak',
                      showDivider: false,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SectionCard(
                  title: 'Kayıtlar',
                  children: [
                    for (var i = 0; i < _sampleLogs.length; i++)
                      _LogRow(
                        date: _sampleLogs[i].date,
                        done: _sampleLogs[i].done,
                        note: _sampleLogs[i].note,
                        showDivider: i > 0,
                      ),
                  ],
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              decoration: const BoxDecoration(
                color: AppColors.background,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TextField(
                    decoration: InputDecoration(hintText: 'Bugün için not (isteğe bağlı)'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(foregroundColor: AppColors.danger),
                        child: const Text('Sil'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          child: const Text('Bugün tamamlandı'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StreakBanner extends StatelessWidget {
  const _StreakBanner({required this.streak});

  final int streak;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Mevcut seri',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.onPrimaryMuted,
            ),
          ),
          Text(
            '$streak gün',
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _LoopRow extends StatelessWidget {
  const _LoopRow({required this.label, required this.value, this.showDivider = true});

  final String label;
  final String value;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: AppColors.divider))
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 14, height: 1.4)),
          ),
        ],
      ),
    );
  }
}

class _LogRow extends StatelessWidget {
  const _LogRow({
    required this.date,
    required this.done,
    required this.note,
    required this.showDivider,
  });

  final String date;
  final bool done;
  final String note;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(top: BorderSide(color: AppColors.divider))
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 64,
            child: Text(date, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  done ? 'Yapıldı' : 'Yapılmadı',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: done ? AppColors.ink : AppColors.danger,
                  ),
                ),
                const SizedBox(height: 2),
                Text(note, style: const TextStyle(fontSize: 13, color: AppColors.muted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
