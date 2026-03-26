import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taqyid/src/theme/app_colors.dart';
import 'package:taqyid/src/theme/app_spacing.dart';
import 'package:taqyid/src/theme/app_text_styles.dart';
import 'package:taqyid/src/viewmodels/library_viewmodel.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Refresh library data on focus
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bookmarksNotifierProvider.notifier).refresh();
      ref.read(notesNotifierProvider.notifier).refresh();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Library'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Bookmarks', icon: Icon(Icons.bookmark_rounded)),
            Tab(text: 'Notes', icon: Icon(Icons.edit_note_rounded)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share_rounded),
            tooltip: 'Export Notes',
            onPressed: () {
              ref.read(notesNotifierProvider.notifier).exportNotes();
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _BookmarksView(),
          _NotesView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Library Tab
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
          }
        },
      ),
    );
  }
}

class _BookmarksView extends ConsumerWidget {
  const _BookmarksView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final bookmarks = ref.watch(bookmarksNotifierProvider);

    if (bookmarks.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.bookmark_border_rounded, size: 64, color: AppColors.primaryGreenSurface),
            const SizedBox(height: AppSpacing.base),
            Text(
              'No Bookmarks Yet',
              style: AppTextStyles.titleMedium.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.base),
      itemCount: bookmarks.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final hadith = bookmarks[index];
        final snippet = hadith.translations.isNotEmpty ? hadith.translations.first : 'No translation available.';

        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(AppSpacing.base),
            title: Text(
              hadith.title,
              style: AppTextStyles.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Text(
                snippet,
                style: AppTextStyles.bodyMedium.copyWith(color: theme.colorScheme.onSurfaceVariant),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle_outline_rounded, color: AppColors.error),
              onPressed: () => ref.read(bookmarksNotifierProvider.notifier).removeBookmark(hadith.id),
            ),
            onTap: () {
              context.push('/hadith/${hadith.id}');
            },
          ),
        );
      },
    );
  }
}

class _NotesView extends ConsumerWidget {
  const _NotesView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final notes = ref.watch(notesNotifierProvider);

    if (notes.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.edit_note_rounded, size: 64, color: AppColors.primaryGreenSurface),
            const SizedBox(height: AppSpacing.base),
            Text(
              'No Notes Saved',
              style: AppTextStyles.titleMedium.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    final entries = notes.entries.toList();

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.base),
      itemCount: entries.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final entry = entries[index];
        final hadithId = entry.key;
        final noteText = entry.value;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.base),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hadith ID: $hadithId',
                      style: AppTextStyles.labelMedium.copyWith(color: theme.colorScheme.primary),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.error),
                      onPressed: () => ref.read(notesNotifierProvider.notifier).removeNote(hadithId),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  noteText,
                  style: AppTextStyles.bodyMedium.copyWith(height: 1.5),
                ),
                const SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                    label: const Text('Read Hadith'),
                    onPressed: () => context.push('/hadith/$hadithId'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
