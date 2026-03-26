import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taqyid/src/models/hadith_simple_model.dart';
import 'package:taqyid/src/services/api_service.dart';
import 'package:taqyid/src/services/hive_storage_service.dart';
import 'package:taqyid/src/viewmodels/language_viewmodel.dart';

part 'search_viewmodel.g.dart';

class SearchState {
  const SearchState({
    this.query = '',
    this.hadiths = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.hasMore = true,
  });

  final String query;
  final List<HadithSimpleModel> hadiths;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final bool hasMore;

  SearchState copyWith({
    String? query,
    List<HadithSimpleModel>? hadiths,
    bool? isLoading,
    String? error,
    int? currentPage,
    bool? hasMore,
  }) {
    return SearchState(
      query: query ?? this.query,
      hadiths: hadiths ?? this.hadiths,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

/// Manages paginated search results
@riverpod
class SearchNotifier extends _$SearchNotifier {
  @override
  SearchState build() {
    return const SearchState();
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      state = const SearchState();
      return;
    }

    // Save search to history
    await HiveStorageService.addSearchEntry(query.trim());
    // Invalidate history provider so UI updates
    ref.invalidate(searchHistoryProvider);

    state = SearchState(query: query.trim());
    await _loadPage(1);
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || !state.hasMore || state.query.isEmpty) return;
    await _loadPage(state.currentPage + 1);
  }

  Future<void> _loadPage(int page) async {
    final lang = ref.read(selectedLanguageNotifierProvider);
    if (lang == null) {
      state = state.copyWith(error: 'Language not selected');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final data = await ApiService.instance.searchHadiths(
        lang: lang,
        term: state.query,
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
}

/// Provides the list of recent search entries from Hive
@riverpod
class SearchHistory extends _$SearchHistory {
  @override
  List<String> build() {
    return HiveStorageService.getSearchHistory();
  }

  Future<void> clearHistory() async {
    await HiveStorageService.clearSearchHistory();
    state = [];
  }
}
