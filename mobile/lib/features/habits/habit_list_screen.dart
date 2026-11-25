import 'package:flutter/material.dart';

import '../../core/routes.dart';
import 'widgets/habit_card.dart';

/// Şablon: liste örnek metinlerle dolu, veri 6. haftada API'den gelecek.
class HabitListScreen extends StatelessWidget {
  const HabitListScreen({super.key});

  static const _sampleHabits = [
    (name: 'Sabah suyu', meta: 'Sağlık · Günde 1 kez', streak: 12, done: true, active: true),
    (name: '20 dk kitap okuma', meta: 'Eğitim · Günde 1 kez', streak: 7, done: false, active: true),
    (name: 'Akşam koşusu', meta: 'Spor · Haftada 3 kez', streak: 2, done: false, active: true),
    (name: 'Ders tekrarı', meta: 'Üretkenlik · Günde 1 kez', streak: 4, done: true, active: true),
    (name: 'Ekransız uyku hazırlığı', meta: 'Uyku · Günde 1 kez', streak: 9, done: false, active: true),
    (name: 'Meditasyon', meta: 'Kategorisiz · Günde 1 kez', streak: 0, done: false, active: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 96),
          children: [
            const Text(
              'Alışkanlıklarım',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.5),
            ),
            const SizedBox(height: 16),
            for (final habit in _sampleHabits)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: HabitCard(
                  name: habit.name,
                  meta: habit.meta,
                  streak: habit.streak,
                  done: habit.done,
                  isActive: habit.active,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.habitDetail),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.habitForm),
        label: const Text(
          '+ Yeni alışkanlık',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
