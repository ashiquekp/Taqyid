import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taqyid/src/views/language/language_selection_screen.dart';
import 'package:taqyid/src/views/splash/splash_screen.dart';

// Placeholder home screen — replaced in Module 3
class _PlaceholderHomeScreen extends StatelessWidget {
  const _PlaceholderHomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Taqyid')),
      body: const Center(child: Text('Home — coming in Module 3')),
    );
  }
}

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
      builder: (_, __) => const _PlaceholderHomeScreen(),
    ),
  ],
);
