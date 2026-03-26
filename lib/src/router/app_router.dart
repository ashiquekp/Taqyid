import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import views as they are created
// Placeholder routes for Module 1 - will be expanded in subsequent modules

final appRouter = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const _PlaceholderSplashScreen(),
    ),
  ],
);

/// Temporary placeholder - replaced in Module 2 with real SplashScreen
class _PlaceholderSplashScreen extends StatelessWidget {
  const _PlaceholderSplashScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'تقييد',
              style: const TextStyle(
                fontFamily: 'Scheherazade',
                fontSize: 56,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Taqyid',
              style: theme.textTheme.headlineLarge?.copyWith(
                color: Colors.white70,
                letterSpacing: 4,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white54),
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
