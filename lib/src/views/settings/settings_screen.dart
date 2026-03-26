import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taqyid/src/services/hive_storage_service.dart';
import 'package:taqyid/src/theme/app_colors.dart';
import 'package:taqyid/src/theme/app_spacing.dart';
import 'package:taqyid/src/theme/app_text_styles.dart';

import 'package:taqyid/src/viewmodels/theme_viewmodel.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late bool _showArabic;

  @override
  void initState() {
    super.initState();
    _showArabic = HiveStorageService.showArabic;
  }

  void _toggleArabic(bool val) async {
    await HiveStorageService.setShowArabic(val);
    setState(() {
      _showArabic = val;
    });
  }

  void _clearCache() async {
    await HiveStorageService.clearCache();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Offline hadith cache cleared.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeViewModelProvider);
    final fontSize = ref.watch(fontSizeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.base),
        children: [
          // Theme Section
          _SectionHeader(title: 'Appearance'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.brightness_medium_rounded),
                  title: const Text('Theme'),
                  trailing: DropdownButton<ThemeMode>(
                    value: themeMode,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text('System'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text('Light'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text('Dark'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        ref.read(themeViewModelProvider.notifier).setTheme(val);
                      }
                    },
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.format_size_rounded),
                  title: const Text('Arabic Text Size'),
                  subtitle: Slider(
                    value: fontSize,
                    min: 16.0,
                    max: 48.0,
                    divisions: 8,
                    label: '${fontSize.toInt()} px',
                    onChanged: (val) {
                      ref.read(fontSizeViewModelProvider.notifier).setFontSize(val);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Reading Preferences
          _SectionHeader(title: 'Reading Preferences'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.translate_rounded),
                  title: const Text('App Language'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    context.push('/language-select');
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.menu_book_rounded),
                  title: const Text('Show Original Arabic'),
                  subtitle: const Text('Always show Arabic alongside translation.'),
                  value: _showArabic,
                  onChanged: _toggleArabic,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Storage
          _SectionHeader(title: 'Storage'),
          Card(
            child: ListTile(
              leading: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
              title: const Text('Clear Offline Cache', style: TextStyle(color: AppColors.error)),
              subtitle: const Text('Removes downloaded categories and hadiths.'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear Cache?'),
                    content: const Text('This will remove all temporarily downloaded reading data. Your bookmarks and notes will be kept.'),
                    actions: [
                      TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.error, foregroundColor: Colors.white),
                        onPressed: () {
                          context.pop();
                          _clearCache();
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // About
          _SectionHeader(title: 'About Taqyid'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.base),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryGreenSurface,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.library_books_rounded, color: AppColors.primaryGreen, size: 32),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text('Taqyid v1.0.0', style: AppTextStyles.titleMedium),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'An open-source application built to preserve and spread the authentic Prophetic traditions.',
                    style: AppTextStyles.bodyMedium.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(height: 32),
                  Text(
                    'Powered by',
                    style: AppTextStyles.labelSmall.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'The Hadeeth Encylopedia (hadeethenc.com)',
                    style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.primary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxxl),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Text(
        title,
        style: AppTextStyles.labelLarge.copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
