
import 'package:taqyid/src/models/hadith_simple_model.dart';
import 'package:taqyid/src/services/api_service.dart';
import 'package:taqyid/src/viewmodels/language_viewmodel.dart';

part 'hadith_list_viewmodel.g.dart';

class HadithListState {
  const HadithListState({
    this.hadiths = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.hasMore = true,
  });

  final List<HadithSimpleModel> hadiths;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final bool hasMore;

  HadithListState copyWith({
    List<HadithSimpleModel>? hadiths,
    bool? isLoading,
    String? error,
    int? currentPage,
    bool? hasMore,
  }) {
    return HadithListState(
      hadiths: hadiths ?? this.hadiths,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

/// Manages paginated list of hadiths for a specific category
@riverpod
class HadithListNotifier extends _$HadithListNotifier {
  @override
  HadithListState build(String categoryId) {
    // Kick off the initial load
    Future.microtask(() => loadPage(1));
    return const HadithListState();
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || !state.hasMore) return;
    await loadPage(state.currentPage + 1);
  }

  Future<void> loadPage(int page) async {
    final lang = ref.read(selectedLanguageNotifierProvider);
    if (lang == null) {
      state = state.copyWith(error: 'Language not selected');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final data = await ApiService.instance.getHadithsList(
        lang: lang,
        categoryId: categoryId,
        page: page,
      );

      final paginated = PaginatedHadiths.fromJson(data);

      state = state.copyWith(
        hadiths: page == 1
            ? paginated.data
            : [...state.hadiths, ...paginated.data],
        currentPage: paginated.meta.currentPage,
        hasMore: paginated.meta.hasNextPage,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> refresh() async {
    await loadPage(1);
  }
}
