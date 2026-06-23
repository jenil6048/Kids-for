import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/app_strings.dart';
import '../constants/app_assets.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_image.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const SplashScreen({super.key, required this.onComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _mascotController;
  late Animation<double> _mascotOffsetAnimation;

  late AnimationController _waveController;
  late Animation<double> _waveRotationAnimation;

  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Floating animation for Mascot
    _mascotController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _mascotOffsetAnimation = Tween<double>(begin: -12.0, end: 12.0).animate(
      CurvedAnimation(parent: _mascotController, curve: Curves.easeInOut),
    );

    // 2. Waving hand animation
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _waveRotationAnimation = Tween<double>(begin: -0.1, end: 0.25).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );

    // 3. Loading progress animation (0 to 100%)
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2800),
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    _progressController.forward().then((_) {
      // Small pause after hitting 100%
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          widget.onComplete();
        }
      });
    });
  }

  @override
  void dispose() {
    _mascotController.dispose();
    _waveController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3E8), // Warm background fallback
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background Immersive Jungle Image
          Positioned.fill(
            child: CustomImage(
              pathOrUrl: AppAssets.jungleBg,
              fit: BoxFit.cover,
              errorWidget: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1B4D3E), Color(0xFF0F2D24)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),

          // Ambient radial dark overlay to focus content
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.4),
                  ],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
          ),

          // Atmospheric Sun Rays (Rotated Yellow Gradients)
          Positioned(
            top: -100,
            left: MediaQuery.of(context).size.width * 0.1,
            child: Transform.rotate(
              angle: -math.pi / 15,
              child: Container(
                width: 140,
                height: 600,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.yellow.withOpacity(0.18),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -100,
            right: MediaQuery.of(context).size.width * 0.2,
            child: Transform.rotate(
              angle: math.pi / 24,
              child: Container(
                width: 180,
                height: 700,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.yellow.withOpacity(0.12),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),

          // Decorative Foreground Leaf (Top-Left Frame Effect)
          Positioned(
            top: -40,
            left: -40,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Icon(
                Icons.eco_rounded,
                size: 160,
                color: const Color(0xFF2E7D32).withOpacity(0.4),
              ),
            ),
          ),
          // Decorative Foreground Leaf (Bottom-Right Frame Effect)
          Positioned(
            bottom: -40,
            right: -40,
            child: Transform.rotate(
              angle: -math.pi / 4,
              child: Icon(
                Icons.eco_rounded,
                size: 160,
                color: const Color(0xFF2E7D32).withOpacity(0.4),
              ),
            ),
          ),

          // Content Column
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),

                // Mascot (Friendly Lion Explorer)
                AnimatedBuilder(
                  animation: _mascotOffsetAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _mascotOffsetAnimation.value),
                      child: child,
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Lion avatar container
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(color: Colors.white.withOpacity(0.3), width: 6),
                        ),
                        child: ClipOval(
                          child: CustomImage(
                            pathOrUrl: AppAssets.lionExplorer,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                            errorWidget: Container(
                              width: 200,
                              height: 200,
                              color: Colors.orange,
                              child: const Icon(Icons.face_rounded, size: 100, color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      // Waving hand Paw bubble
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: AnimatedBuilder(
                          animation: _waveRotationAnimation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _waveRotationAnimation.value,
                              child: child,
                            );
                          },
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFCC80),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: const Icon(
                              Icons.front_hand_rounded,
                              color: Color(0xFF7C5730),
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 36),

                // App Title Glassmorphic Card
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      CustomText(
                        tr(AppStrings.appTitle),
                        textAlign: TextAlign.center,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF9E2A2B),
                        letterSpacing: 0.2,
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        tr(AppStrings.letsExplore),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF7C5730),
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 4),

                // Gamified Progress Bar
                AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    final percent = (_progressAnimation.value * 100).toInt();

                    return Column(
                      children: [
                        // Progress track
                        Container(
                          width: double.infinity,
                          height: 22,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.white.withOpacity(0.3)),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: _progressAnimation.value,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF66BB6A), Color(0xFF43A047)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: const Offset(0, 1),
                                  )
                                ],
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 2.0),
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFFD93D),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.star,
                                      size: 8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Loading Status Text & Percentage
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              tr(AppStrings.loading),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            CustomText(
                              '$percent%',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFFFFD93D),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
