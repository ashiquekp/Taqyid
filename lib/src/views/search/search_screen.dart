import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taqyid/src/models/hadith_simple_model.dart';
import 'package:taqyid/src/services/hive_storage_service.dart';
import 'package:taqyid/src/theme/app_colors.dart';
import 'package:taqyid/src/theme/app_spacing.dart';
import 'package:taqyid/src/theme/app_text_styles.dart';
import 'package:taqyid/src/viewmodels/search_viewmodel.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(searchNotifierProvider.notifier).loadNextPage();
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      if (mounted) {
        ref.read(searchNotifierProvider.notifier).search(query);
      }
    });
  }

  void _onSubmitted(String query) {
    _debounce?.cancel();
    ref.read(searchNotifierProvider.notifier).search(query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search hadiths...',
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            hintStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.white54),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear_rounded, color: Colors.white),
                    onPressed: () {
                      _searchController.clear();
                      _onSearchChanged('');
                      setState(() {});
                    },
                  )
                : null,
          ),
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
          textInputAction: TextInputAction.search,
          onChanged: (v) {
            setState(() {});
            _onSearchChanged(v);
          },
          onSubmitted: _onSubmitted,
        ),
      ),
      body: searchState.query.isEmpty
          ? const _SearchHistoryView()
          : _SearchResultsView(searchState: searchState, scrollController: _scrollController),
    );
  }
}

class _SearchHistoryView extends ConsumerWidget {
  const _SearchHistoryView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(searchHistoryProvider);
    final theme = Theme.of(context);

    if (history.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_rounded, size: 64, color: AppColors.primaryGreenSurface),
            const SizedBox(height: AppSpacing.base),
            Text(
              'Search the Sunnah',
              style: AppTextStyles.titleLarge.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.base),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Searches', style: AppTextStyles.titleMedium),
              TextButton(
                onPressed: () => ref.read(searchHistoryProvider.notifier).clearHistory(),
                child: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: history.map((term) {
              return ActionChip(
                label: Text(term),
                onPressed: () {
                  // Push search to field
                  final screenState = context.findAncestorStateOfType<_SearchScreenState>()!;
                  screenState._searchController.text = term;
                  screenState._onSubmitted(term);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _SearchResultsView extends StatelessWidget {
  const _SearchResultsView({
    required this.searchState,
    required this.scrollController,
  });

  final SearchState searchState;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (searchState.isLoading && searchState.hadiths.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (searchState.error != null && searchState.hadiths.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Text(
            searchState.error!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.error),
          ),
        ),
      );
    }

    if (searchState.hadiths.isEmpty) {
      return const Center(child: Text('No matching hadiths found.'));
    }

    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.all(AppSpacing.base),
      itemCount: searchState.hadiths.length + (searchState.hasMore ? 1 : 0),
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        if (index == searchState.hadiths.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final hadith = searchState.hadiths[index];
        return _SearchHadithCard(hadith: hadith);
      },
    );
  }
}

class _SearchHadithCard extends StatefulWidget {
  const _SearchHadithCard({required this.hadith});
  final HadithSimpleModel hadith;

  @override
  State<_SearchHadithCard> createState() => _SearchHadithCardState();
}

class _SearchHadithCardState extends State<_SearchHadithCard> {
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
    setState(() => _isBookmarked = !_isBookmarked);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String snippet = widget.hadith.translations.isNotEmpty
        ? widget.hadith.translations.first
        : 'No translation available.';

    return Card(
      child: InkWell(
        onTap: () {
          context.push('/hadith/${widget.hadith.id}');
        },
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
                      style: AppTextStyles.titleMedium.copyWith(color: theme.colorScheme.onSurface, height: 1.5),
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
                style: AppTextStyles.bodyMedium.copyWith(color: theme.colorScheme.onSurfaceVariant),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
