import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:taqyid/src/models/hadith_detail_model.dart';
import 'package:taqyid/src/services/hive_storage_service.dart';
import 'package:taqyid/src/theme/app_colors.dart';
import 'package:taqyid/src/theme/app_spacing.dart';
import 'package:taqyid/src/theme/app_text_styles.dart';
import 'package:taqyid/src/viewmodels/hadith_detail_viewmodel.dart';

class HadithDetailScreen extends ConsumerStatefulWidget {
  const HadithDetailScreen({
    super.key,
    required this.hadithId,
  });

  final String hadithId;

  @override
  ConsumerState<HadithDetailScreen> createState() => _HadithDetailScreenState();
}

class _HadithDetailScreenState extends ConsumerState<HadithDetailScreen> {
  late bool _showArabic;
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();
    _showArabic = HiveStorageService.showArabic;
    _isBookmarked = HiveStorageService.isBookmarked(widget.hadithId);
  }

  void _toggleBookmark(HadithDetailModel hadith) async {
    if (_isBookmarked) {
      await HiveStorageService.removeBookmark(hadith.id);
    } else {
      await HiveStorageService.addBookmark(hadith.id, hadith.toJson());
    }
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isBookmarked ? 'Added to Bookmarks' : 'Removed from Bookmarks'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _toggleArabic() async {
    final nextState = !_showArabic;
    await HiveStorageService.setShowArabic(nextState);
    setState(() {
      _showArabic = nextState;
    });
  }

  void _shareHadith(HadithDetailModel hadith) {
    final text = '''
${hadith.title}

${hadith.hadeeth}

Grade: ${hadith.grade}
Narrator: ${hadith.attribution}

---
Shared via Taqyid App
https://hadeethenc.com/en/browse/hadith/${hadith.id}
''';
    Share.share(text);
  }

  void _copyHadith(HadithDetailModel hadith) {
    final text = '${hadith.hadeeth}\n\n[Grade: ${hadith.grade}] - ${hadith.attribution}';
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  void _openNotesSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _NotesBottomSheet(hadithId: widget.hadithId),
    );
  }

  Color _getGradeColor(String gradeName, TaqyidColors? customColors) {
    final g = gradeName.toLowerCase();
    if (customColors == null) return AppColors.unknown;
    if (g.contains('sahih')) return customColors.sahih;
    if (g.contains('hasan')) return customColors.hasan;
    if (g.contains('daif') || g.contains('weak')) return customColors.daif;
    if (g.contains('mawdu') || g.contains('fabricated')) return customColors.mawdu;
    return AppColors.unknown;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<TaqyidColors>();
    final asyncDetail = ref.watch(hadithDetailProvider(widget.hadithId));

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              _showArabic ? Icons.translate_rounded : Icons.sort_by_alpha_rounded,
            ),
            tooltip: 'Toggle Original Arabic',
            onPressed: _toggleArabic,
          ),
          asyncDetail.maybeWhen(
            data: (hadith) => IconButton(
              icon: Icon(
                _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                color: _isBookmarked ? AppColors.bookmark : null,
              ),
              onPressed: () => _toggleBookmark(hadith),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openNotesSheet,
        tooltip: 'Add Note',
        child: const Icon(Icons.edit_note_rounded),
      ),
      body: asyncDetail.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text(err.toString())),
        data: (hadith) => SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: AppSpacing.xl,
            right: AppSpacing.xl,
            top: AppSpacing.base,
            bottom: AppSpacing.xxxl * 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Header Row ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      hadith.attribution,
                      style: AppTextStyles.labelLarge.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  Chip(
                    label: Text(
                      hadith.grade,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: _getGradeColor(hadith.grade, customColors),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.base),

              // --- Main Text ---
              Text(
                hadith.hadeeth,
                style: AppTextStyles.bodyLarge.copyWith(height: 1.8),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: AppSpacing.xl),

              // --- Action Bar ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _copyHadith(hadith),
                    icon: const Icon(Icons.copy_rounded, size: 20),
                    label: const Text('Copy'),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  ElevatedButton.icon(
                    onPressed: () => _shareHadith(hadith),
                    icon: const Icon(Icons.share_rounded, size: 20),
                    label: const Text('Share'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // --- Explanation Card ---
              if (hadith.explanation.isNotEmpty) ...[
                const Divider(),
                const SizedBox(height: AppSpacing.md),
                Text('Explanation', style: AppTextStyles.titleLarge),
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.base),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Text(
                    hadith.explanation,
                    style: AppTextStyles.bodyMedium.copyWith(height: 1.6),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],

              // --- Keys / Hints ---
              if (hadith.hints.isNotEmpty) ...[
                Text('Key Lessons', style: AppTextStyles.titleLarge),
                const SizedBox(height: AppSpacing.md),
                ...hadith.hints.map((hint) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.adjust_rounded, size: 16, color: theme.colorScheme.primary),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Text(
                              hint,
                              style: AppTextStyles.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: AppSpacing.xl),
              ],

              // --- Words Meaning ---
              if (hadith.wordsMeanings.isNotEmpty) ...[
                const Divider(),
                const SizedBox(height: AppSpacing.md),
                Text('Word Meanings', style: AppTextStyles.titleLarge),
                const SizedBox(height: AppSpacing.md),
                ...hadith.wordsMeanings.map((wm) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.bodyMedium.copyWith(color: theme.colorScheme.onSurface),
                          children: [
                            TextSpan(
                              text: '${wm.word}: ',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: wm.meaning,
                              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NotesBottomSheet extends ConsumerStatefulWidget {
  const _NotesBottomSheet({required this.hadithId});
  final String hadithId;

  @override
  ConsumerState<_NotesBottomSheet> createState() => _NotesBottomSheetState();
}

class _NotesBottomSheetState extends ConsumerState<_NotesBottomSheet> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final currentNote = ref.read(hadithNoteNotifierProvider(widget.hadithId));
    _controller = TextEditingController(text: currentNote ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() async {
    await ref.read(hadithNoteNotifierProvider(widget.hadithId).notifier).saveNote(_controller.text);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(
        left: AppSpacing.xl,
        right: AppSpacing.xl,
        top: AppSpacing.xl,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('My Notes', style: AppTextStyles.titleLarge),
              IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close_rounded))
            ],
          ),
          const SizedBox(height: AppSpacing.base),
          TextField(
            controller: _controller,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Add personal reflections or lessons learned...',
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          ElevatedButton(
            onPressed: _save,
            child: const Text('Save Note'),
          ),
        ],
      ),
    );
  }
}
