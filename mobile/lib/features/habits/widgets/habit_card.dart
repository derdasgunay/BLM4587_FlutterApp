import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({
    super.key,
    required this.name,
    required this.meta,
    required this.streak,
    required this.done,
    required this.isActive,
    required this.onTap,
  });

  final String name;
  final String meta;
  final int streak;
  final bool done;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final card = Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        if (!isActive) const _PassiveBadge(),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(meta, style: const TextStyle(fontSize: 13, color: AppColors.muted)),
                    const SizedBox(height: 4),
                    Text(
                      'Seri: $streak gün',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
              if (isActive) _CheckCircle(done: done),
            ],
          ),
        ),
      ),
    );

    return isActive ? card : Opacity(opacity: 0.6, child: card);
  }
}

class _PassiveBadge extends StatelessWidget {
  const _PassiveBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Text('Pasif', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
    );
  }
}

/// Bugün tamamlandı işareti (şimdilik yalnızca görünüm).
class _CheckCircle extends StatelessWidget {
  const _CheckCircle({required this.done});

  final bool done;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: done ? AppColors.primary : Colors.white,
        border: Border.all(
          color: done ? AppColors.primary : AppColors.checkBorder,
          width: 2,
        ),
      ),
      child: done ? const Icon(Icons.check_rounded, color: AppColors.ink, size: 22) : null,
    );
  }
}
