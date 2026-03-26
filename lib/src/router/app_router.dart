
import 'package:go_router/go_router.dart';
import 'package:taqyid/src/views/category/category_list_screen.dart';
import 'package:taqyid/src/views/hadith/hadith_detail_screen.dart';
import 'package:taqyid/src/views/hadith/hadith_list_screen.dart';
import 'package:taqyid/src/views/search/search_screen.dart';
import 'package:taqyid/src/views/library/library_screen.dart';
import 'package:taqyid/src/views/home/home_screen.dart';
import 'package:taqyid/src/views/language/language_selection_screen.dart';
import 'package:taqyid/src/views/splash/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: '/language-select',
      name: 'language-select',
      builder: (_, __) => const LanguageSelectionScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: '/category/:id',
      name: 'category-detail',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final extra = state.extra as Map<String, dynamic>? ?? {};
        final title = extra['title'] as String? ?? 'Category';
        final breadcrumbs = extra['breadcrumbs'] as List<String>? ?? [title];
        
        return CategoryListScreen(
          categoryId: id,
          title: title,
          breadcrumbs: breadcrumbs,
        );
      },
    ),
    GoRoute(
      path: '/hadiths/:categoryId',
      name: 'hadith-list',
      builder: (context, state) {
        final categoryId = state.pathParameters['categoryId']!;
        final title = state.extra as String? ?? 'Hadiths';
        return HadithListScreen(categoryId: categoryId, title: title);
      },
    ),
    GoRoute(
      path: '/hadith/:id',
      name: 'hadith-detail',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return HadithDetailScreen(hadithId: id);
      },
    ),
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (_, __) => const SearchScreen(),
    ),
    GoRoute(
      path: '/library',
      name: 'library',
      builder: (_, __) => const LibraryScreen(),
    ),
  ],
);
