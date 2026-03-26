import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taqyid/src/models/hadith_simple_model.dart';
import 'package:taqyid/src/services/hive_storage_service.dart';
import 'package:taqyid/src/theme/app_colors.dart';
import 'package:taqyid/src/theme/app_spacing.dart';
import 'package:taqyid/src/theme/app_text_styles.dart';
import 'package:taqyid/src/viewmodels/hadith_list_viewmodel.dart';

class HadithListScreen extends ConsumerStatefulWidget {
  const HadithListScreen({
    super.key,
    required this.categoryId,
    required this.title,
  });

  final String categoryId;
  final String title;

  @override
  ConsumerState<HadithListScreen> createState() => _HadithListScreenState();
}

class _HadithListScreenState extends ConsumerState<HadithListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(hadithListNotifierProvider(widget.categoryId).notifier).loadNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hadithListNotifierProvider(widget.categoryId));
    final notifier = ref.read(hadithListNotifierProvider(widget.categoryId).notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(state, notifier),
    );
  }

  Widget _buildBody(HadithListState state, HadithListNotifier notifier) {
    if (state.isLoading && state.hadiths.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.hadiths.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded, size: 48, color: AppColors.error),
            const SizedBox(height: AppSpacing.sm),
            Text('Failed to load hadiths', style: Theme.of(context).textTheme.titleMedium),
            Text(state.error!, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton(
              onPressed: () => notifier.refresh(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.hadiths.isEmpty) {
      return const Center(child: Text('No hadiths found in this category.'));
    }

    return RefreshIndicator(
      onRefresh: () => notifier.refresh(),
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.all(AppSpacing.base),
        itemCount: state.hadiths.length + (state.hasMore ? 1 : 0),
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          if (index == state.hadiths.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final hadith = state.hadiths[index];
          return _HadithCard(
            hadith: hadith,
            onTap: () {
              // Placeholder for Module 5
              context.push('/hadith/${hadith.id}');
            },
          );
        },
      ),
    );
  }
}

class _HadithCard extends StatefulWidget {
  const _HadithCard({
    required this.hadith,
    required this.onTap,
  });

  final HadithSimpleModel hadith;
  final VoidCallback onTap;

  @override
  State<_HadithCard> createState() => _HadithCardState();
}

class _HadithCardState extends State<_HadithCard> {
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();
    _isBookmarked = HiveStorageService.isBookmarked(widget.hadith.id);
  }

  void _toggleBookmark() async {
    if (_isBookmarked) {
      await HiveStorageService.removeBookmark(widget.hadith.id);
    } else {
      await HiveStorageService.addBookmark(widget.hadith.id, widget.hadith.toJson());
    }
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String snippet = widget.hadith.translations.isNotEmpty
        ? widget.hadith.translations.first
        : 'No translation available.';

    return Card(
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.base),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.hadith.title,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: theme.colorScheme.onSurface,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  IconButton(
                    icon: Icon(
                      _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                      color: _isBookmarked ? AppColors.bookmark : theme.colorScheme.onSurfaceVariant,
                    ),
                    onPressed: _toggleBookmark,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                snippet,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.md),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'ID: ${widget.hadith.id}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
