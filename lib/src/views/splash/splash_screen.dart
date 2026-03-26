import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taqyid/src/services/hive_storage_service.dart';
import 'package:taqyid/src/theme/app_colors.dart';
import 'package:taqyid/src/theme/app_text_styles.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward().then((_) => _navigate());
  }

  void _navigate() {
    if (!mounted) return;
    final langSelected = HiveStorageService.selectedLanguage != null &&
        !HiveStorageService.isFirstLaunch;

    if (langSelected) {
      context.go('/home');
    } else {
      context.go('/language-select');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: ScaleTransition(
          scale: _scaleAnim,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Arabic logo
                Text(
                  'تقييد',
                  style: AppTextStyles.arabicLarge.copyWith(
                    fontSize: 68,
                    color: Colors.white,
                    shadows: [
                      const Shadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Latin tagline
                Text(
                  'T A Q Y I D',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: Colors.white70,
                    letterSpacing: 6,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Preserve the Sunnah',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white54,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 72),
                // Decorative divider
                Container(
                  width: 40,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
