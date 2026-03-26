import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taqyid/src/theme/app_colors.dart';
import 'package:taqyid/src/theme/app_spacing.dart';
import 'package:taqyid/src/theme/app_text_styles.dart';
import 'package:taqyid/src/viewmodels/category_viewmodel.dart';
import 'package:taqyid/src/models/category_model.dart';

class CategoryListScreen extends ConsumerWidget {
  const CategoryListScreen({
    super.key,
    required this.categoryId,
    required this.title,
    required this.breadcrumbs,
  });

  final String categoryId;
  final String title;
  final List<String> breadcrumbs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final childrenAsync = ref.watch(categoryChildrenProvider(categoryId));

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: _BreadcrumbNav(breadcrumbs: breadcrumbs),
        ),
      ),
      body: childrenAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (categories) {
          if (categories.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.library_books_rounded, size: 64, color: AppColors.primaryGreenSurface),
                  const SizedBox(height: AppSpacing.base),
                  Text('No subcategories found', style: theme.textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.sm),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate directly to hadiths list in Module 4
                      context.push('/hadiths/$categoryId', extra: title);
                    },
                    child: const Text('View Hadiths'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.base),
                  itemCount: categories.length + 1, // +1 for view all hadiths button
                  separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return OutlinedButton.icon(
                        icon: const Icon(Icons.format_list_bulleted_rounded),
                        label: Text('View All Hadiths in "$title"'),
                        onPressed: () {
                          // Navigate to hadith list for this exact category
                          context.push('/hadiths/$categoryId', extra: title);
                        },
                      );
                    }
                    
                    final category = categories[index - 1];
                    return _SubcategoryTile(
                      category: category,
                      onTap: () {
                        context.push(
                          '/category/${category.id}',
                          extra: {
                            'title': category.title,
                            'breadcrumbs': [...breadcrumbs, category.title],
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BreadcrumbNav extends StatelessWidget {
  const _BreadcrumbNav({required this.breadcrumbs});

  final List<String> breadcrumbs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primaryGreenDark,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.sm),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: true, // Auto-scroll to end (Arabic RTL or just long chains)
        child: Row(
          children: List.generate(
            breadcrumbs.length,
            (index) {
              final isLast = index == breadcrumbs.length - 1;
              return Row(
                children: [
                  Text(
                    breadcrumbs[index],
                    style: AppTextStyles.labelMedium.copyWith(
                      color: isLast ? Colors.white : Colors.white54,
                      fontWeight: isLast ? FontWeight.w700 : FontWeight.w400,
                    ),
                  ),
                  if (!isLast)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Icon(Icons.chevron_right_rounded, size: 16, color: Colors.white54),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SubcategoryTile extends StatelessWidget {
  const _SubcategoryTile({required this.category, required this.onTap});

  final CategoryModel category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusLg)),
      tileColor: theme.colorScheme.surface,
      title: Text(
        category.title,
        style: AppTextStyles.titleMedium.copyWith(color: theme.colorScheme.onSurface),
      ),
      subtitle: Text(
        '${category.hadeethsCount} Hadiths',
        style: AppTextStyles.labelSmall.copyWith(color: AppColors.accentGold),
      ),
      trailing: Container(
        padding: const EdgeInsets.all(AppSpacing.xs),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.chevron_right_rounded,
          size: 20,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
