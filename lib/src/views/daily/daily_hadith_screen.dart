import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:taqyid/src/theme/app_colors.dart';
import 'package:taqyid/src/theme/app_spacing.dart';
import 'package:taqyid/src/theme/app_text_styles.dart';
import 'package:taqyid/src/viewmodels/daily_hadith_viewmodel.dart';

class DailyHadithScreen extends ConsumerWidget {
  const DailyHadithScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dailyAsync = ref.watch(dailyHadithProvider);
    final streakData = ref.watch(streakNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Inspiration'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Push notifications configuration coming soon.')),
              );
            },
            tooltip: 'Configure Notifications',
          ),
        ],
      ),
      body: dailyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text(err.toString())),
        data: (hadith) {
          if (hadith == null) {
            return const Center(child: Text('Failed to load daily hadith.'));
          }

          final now = DateTime.now();
          final todayStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
          final hasReadToday = streakData.lastReadDate == todayStr;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.base),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Streak Card
                Row(
                  children: [
                    Expanded(
                      child: _StreakMetric(
                        title: 'Current Streak',
                        value: streakData.currentStreak.toString(),
                        icon: Icons.local_fire_department_rounded,
                        color: AppColors.accentGold,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.base),
                    Expanded(
                      child: _StreakMetric(
                        title: 'Longest Streak',
                        value: streakData.longestStreak.toString(),
                        icon: Icons.emoji_events_rounded,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                // Date Header
                Text(
                  'Hadith of the Day',
                  style: AppTextStyles.titleLarge.copyWith(color: theme.colorScheme.primary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),

                // Hadith Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusXl)),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Column(
                      children: [
                        const Icon(Icons.format_quote_rounded, size: 48, color: AppColors.primaryGreenSurface),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          hadith.title,
                          style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          hadith.translations.isNotEmpty ? hadith.translations.first : 'No translation',
                          style: AppTextStyles.bodyLarge.copyWith(height: 1.6),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (!hasReadToday) {
                              ref.read(streakNotifierProvider.notifier).markDailyRead();
                            }
                            context.push('/hadith/${hadith.id}');
                          },
                          icon: Icon(hasReadToday ? Icons.check_circle_rounded : Icons.menu_book_rounded),
                          label: Text(hasReadToday ? 'Read Again' : 'Read Full Hadith & Mark Done'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(48),
                            backgroundColor: hasReadToday ? theme.colorScheme.surfaceContainerHighest : theme.colorScheme.primary,
                            foregroundColor: hasReadToday ? theme.colorScheme.onSurface : theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Daily Tab
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_rounded),
            label: 'Daily',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_rounded),
            label: 'Library',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            context.go('/home');
          } else if (index == 2) {
            context.go('/library');
          }
        },
      ),
    );
  }
}

class _StreakMetric extends StatelessWidget {
  const _StreakMetric({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: AppTextStyles.labelSmall.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
