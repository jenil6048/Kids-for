import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/app_strings.dart';
import '../constants/app_assets.dart';
import '../models/category_model.dart';
import '../models/group_model.dart';
import '../models/localized_text.dart';
import '../repositories/category_repository.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_image.dart';
import '../widgets/language_selector.dart';
import '../widgets/custom_loading.dart';
import 'topic_detail_screen.dart';
import 'settings_screen.dart';
import '../repositories/auth_repository.dart';
import '../repositories/config_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Future<List<CategoryModel>> _categoriesFuture;

  late AnimationController _cloudsController;
  late Animation<double> _cloudsAnimation;

  @override
  void initState() {
    super.initState();
    _loadCategories();

    _cloudsController = AnimationController(duration: const Duration(seconds: 40), vsync: this)..repeat();

    _cloudsAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _cloudsController, curve: Curves.linear));
  }

  @override
  void dispose() {
    _cloudsController.dispose();
    super.dispose();
  }

  void _loadCategories() {
    setState(() {
      _categoriesFuture = CategoryRepository.instance.getCategories();
    });
  }

  Color _parseHexColor(String hexString) {
    try {
      final buffer = StringBuffer();
      if (hexString.startsWith('#')) {
        hexString = hexString.substring(1);
      }
      if (hexString.length == 6) {
        buffer.write('ff');
      }
      buffer.write(hexString);
      final colorVal = int.tryParse(buffer.toString(), radix: 16);
      return colorVal != null ? Color(colorVal) : const Color(0xFFFFCC80);
    } catch (_) {
      return const Color(0xFFFFCC80);
    }
  }

  Map<GroupModel, List<CategoryModel>> _groupCategories(List<CategoryModel> categories) {
    final Map<String, GroupModel> groupMap = {};
    final Map<String, List<CategoryModel>> groupedByCategoryKey = {};

    for (var cat in categories) {
      final GroupModel group;
      if (cat.group != null) {
        group = cat.group!;
      } else {
        group = GroupModel(
          id: cat.groupId.isNotEmpty ? cat.groupId : 'other',
          name: LocalizedText(en: 'Other Exploration', gu: 'અન્ય સંશોધન', hi: 'अन्य अन्વેषण'),
          icon: 'https://assets5.lottiefiles.com/packages/lf20_qp1a7a00.json',
          displayOrder: 999, // default to bottom if group is unlinked
        );
      }

      groupMap[group.id] = group;
      groupedByCategoryKey.putIfAbsent(group.id, () => []).add(cat);
    }

    // Sort groups alphabetically or by displayOrder
    final sortedGroups = groupMap.values.toList();
    sortedGroups.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

    final Map<GroupModel, List<CategoryModel>> result = {};
    for (var group in sortedGroups) {
      final cats = groupedByCategoryKey[group.id]!;
      // Sort categories within the group by displayOrder
      cats.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
      result[group] = cats;
    }

    return result;
  }

  Widget _buildSmilingSun() {
    return Positioned(
      top: 30,
      right: 20,
      child: AnimatedBuilder(
        animation: _cloudsAnimation,
        builder: (context, child) {
          final scale = 1.0 + math.sin(_cloudsAnimation.value * 2 * math.pi) * 0.05;
          return Transform.scale(scale: scale, child: child);
        },
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFFFD93D),
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [BoxShadow(color: const Color(0xFFFFB74D).withOpacity(0.5), blurRadius: 12, spreadRadius: 2)],
          ),
          child: const Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.wb_sunny_rounded, color: Colors.white, size: 45),
              Positioned(
                top: 24,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.brightness_1, color: Color(0xFF7C5730), size: 5),
                    SizedBox(width: 8),
                    Icon(Icons.brightness_1, color: Color(0xFF7C5730), size: 5),
                  ],
                ),
              ),
              Positioned(top: 32, child: Icon(Icons.sentiment_satisfied_alt_rounded, color: Color(0xFF7C5730), size: 22)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCloud(double top, double scale, double speedOffset) {
    return AnimatedBuilder(
      animation: _cloudsAnimation,
      builder: (context, child) {
        final screenWidth = MediaQuery.of(context).size.width;
        final value = (_cloudsAnimation.value + speedOffset) % 1.0;
        final xPos = -180.0 + value * (screenWidth + 360.0);
        return Positioned(
          top: top,
          left: xPos,
          child: Transform.scale(
            scale: scale,
            child: Opacity(opacity: 0.8, child: child),
          ),
        );
      },
      child: const Icon(Icons.cloud_rounded, color: Colors.white, size: 120),
    );
  }

  Widget _buildSpeechBubble(String title, String subtitle) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFFFD93D), width: 3),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(title, fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF7C5730)),
              const SizedBox(height: 2),
              CustomText(subtitle, fontSize: 18, maxLines: 2, fontWeight: FontWeight.w900, color: const Color(0xFF9E2A2B)),
            ],
          ),
        ),
        // Pointer pointing right
        Positioned(
          right: -8,
          top: 25,
          child: Transform.rotate(
            angle: math.pi / 4,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: const Color(0xFFFFD93D), width: 3),
                  right: BorderSide(color: const Color(0xFFFFD93D), width: 3),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLang = context.locale.languageCode;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE0F7FA), // Soft sky cyan
              Color(0xFFFFF9C4), // Warm pastel yellow
              Color(0xFFE8F5E9), // Soft land mint green
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Smiling sun in background
            _buildSmilingSun(),

            // Floating background clouds
            _buildCloud(60, 0.7, 0.15),
            _buildCloud(220, 1.1, 0.65),
            _buildCloud(400, 0.8, 0.4),

            // Additional playful background bubbles
            Positioned(
              bottom: -60,
              left: -60,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.25)),
              ),
            ),
            Positioned(
              bottom: 80,
              right: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.15)),
              ),
            ),

            SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  try {
                    await ConfigRepository.instance.fetchAndSync();
                  } catch (_) {}
                  setState(() {
                    _categoriesFuture = CategoryRepository.instance.getCategories(forceRefresh: true);
                  });
                  await _categoriesFuture;
                },
                color: const Color(0xFF2E7D32),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // App Header
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 0.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Greeting speech bubble
                                Expanded(
                                  child: _buildSpeechBubble(tr(AppStrings.helloExplorer), tr(AppStrings.chooseAdventure)),
                                ),
                                const SizedBox(width: 14),
                                // Lion Explorer avatar (Tappable for Settings)
                                GestureDetector(
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                                  },
                                  child: ValueListenableBuilder<UserModel?>(
                                    valueListenable: AuthRepository.instance.currentUserNotifier,
                                    builder: (context, user, child) {
                                      return Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(color: const Color(0xFFFFD93D), width: 3),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.12),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: ClipOval(
                                          child: CustomImage(
                                            pathOrUrl: user?.avatarUrl ?? AppAssets.lionExplorer,
                                            width: 64,
                                            height: 64,
                                            fit: BoxFit.cover,
                                            errorWidget: Container(
                                              width: 64,
                                              height: 64,
                                              color: Colors.orange,
                                              child: const Icon(Icons.face_rounded, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            // Language Selection row & Settings button
                            Row(
                              spacing: 12,
                              children: [
                                const Expanded(
                                  child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: LanguageSelector()),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    HapticFeedback.mediumImpact();
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0xFFFFD93D), width: 3),
                                      boxShadow: [BoxShadow(color: const Color(0xFFD7D3C5), offset: const Offset(0, 4))],
                                    ),
                                    child: const Icon(Icons.settings_rounded, color: Color(0xFF2E7D32), size: 24),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Supabase Fetch Content
                    FutureBuilder<List<CategoryModel>>(
                      future: _categoriesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomLoading(width: 150, height: 30, borderRadius: 15),
                                    const SizedBox(height: 15),
                                    SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 3,
                                        itemBuilder: (context, i) => const Padding(
                                          padding: EdgeInsets.only(right: 15),
                                          child: CustomLoading(width: 160, height: 200, borderRadius: 28),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              childCount: 2,
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.error_outline_rounded, size: 64, color: Color(0xFF9E2A2B)),
                                    const SizedBox(height: 16),
                                    CustomText(
                                      tr(AppStrings.connectionIssues),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF9E2A2B),
                                    ),
                                    const SizedBox(height: 8),
                                    CustomText(
                                      tr(AppStrings.checkNetwork),
                                      fontSize: 14,
                                      textAlign: TextAlign.center,
                                      color: Colors.grey.shade600,
                                    ),
                                    const SizedBox(height: 24),
                                    CustomButton(
                                      backgroundColor: const Color(0xFF2E7D32),
                                      onPressed: _loadCategories,
                                      child: CustomText(
                                        tr(AppStrings.retry),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }

                        final categories = snapshot.data ?? [];
                        if (categories.isEmpty) {
                          return SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(
                              child: FutureBuilder<List<ConnectivityResult>>(
                                future: Connectivity().checkConnectivity(),
                                builder: (ctx, connSnap) {
                                  final isOffline =
                                      connSnap.data != null && connSnap.data!.every((r) => r == ConnectivityResult.none);
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        isOffline ? Icons.wifi_off_rounded : Icons.sentiment_dissatisfied_rounded,
                                        size: 64,
                                        color: isOffline ? const Color(0xFF9E2A2B) : Colors.orange,
                                      ),
                                      const SizedBox(height: 16),
                                      CustomText(
                                        isOffline ? 'Please turn on internet to start' : tr(AppStrings.noAdventures),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.center,
                                        color: isOffline ? const Color(0xFF9E2A2B) : const Color(0xFF7C5730),
                                      ),
                                      if (isOffline) ...[
                                        const SizedBox(height: 8),
                                        CustomText(
                                          'Connect to the internet so we can\ndownload your adventures!',
                                          fontSize: 14,
                                          textAlign: TextAlign.center,
                                          color: Colors.grey.shade600,
                                        ),
                                        const SizedBox(height: 24),
                                        CustomButton(
                                          backgroundColor: const Color(0xFF2E7D32),
                                          onPressed: _loadCategories,
                                          child: const CustomText(
                                            'Try Again',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        }

                        final grouped = _groupCategories(categories);

                        return SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) {
                            final group = grouped.keys.elementAt(index);
                            final groupCategories = grouped[group]!;

                            return _buildGroupRow(group, groupCategories, currentLang);
                          }, childCount: grouped.keys.length),
                        );
                      },
                    ),

                    // Extra bottom padding
                    const SliverToBoxAdapter(child: SizedBox(height: 40)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupRow(GroupModel group, List<CategoryModel> categories, String locale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group Header
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 12.0),
          child: Row(
            children: [
              // Group Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF4CAF50), width: 3),
                  boxShadow: [BoxShadow(color: const Color(0xFF2E7D32).withOpacity(0.3), offset: const Offset(0, 4))],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CustomImage(pathOrUrl: group.icon),
                ),
              ),
              const SizedBox(width: 12),
              // Group Name inside a playful speech-pill banner
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFC8E6C9), width: 2),
                ),
                child: CustomText(
                  group.getName(locale: locale),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF2E7D32),
                ),
              ),
            ],
          ),
        ),

        // Horizontal list of Categories
        SizedBox(
          height: 235,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryCard3D(
                category: category,
                locale: locale,
                cardColor: _parseHexColor(category.color),
                onTap: () {
                  _showCategoryActionDialog(category, locale);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showCategoryActionDialog(CategoryModel category, String locale) {
    final themeColor = _parseHexColor(category.color);
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'CategoryDialog',
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
      transitionBuilder: (context, anim1, anim2, child) {
        final scale = 1.0 + (1.0 - anim1.value) * -0.15;
        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: anim1.value,
            child: AlertDialog(
              backgroundColor: const Color(0xFFF5F3E8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: BorderSide(color: themeColor, width: 4),
              ),
              title: Row(
                children: [
                  Icon(category.isPremium ? Icons.star_rounded : Icons.explore_rounded, color: themeColor, size: 32),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CustomText(
                      category.getTitle(locale: locale),
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF9E2A2B),
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(color: themeColor.withOpacity(0.15), shape: BoxShape.circle),
                      child: CustomImage(
                        fit: BoxFit.fill,
                        pathOrUrl: (category.lottiePath != null && category.lottiePath!.toLowerCase().contains('.json'))
                            ? category.lottiePath!
                            : (category.imagePath ?? ''),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    category.isPremium ? tr(AppStrings.unlockPremium) : tr(AppStrings.readyExplore),
                    fontSize: 16,
                    maxLines: 3,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    color: const Color(0xFF7C5730),
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                CustomButton(
                  backgroundColor: Colors.grey.shade400,
                  onPressed: () => Navigator.of(context).pop(),
                  child: CustomText(tr(AppStrings.goBack), fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                CustomButton(
                  backgroundColor: themeColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryTopicsScreen(category: category, activeLanguage: locale),
                      ),
                    );
                  },
                  child: CustomText(
                    category.isPremium ? tr(AppStrings.unlockStar) : tr(AppStrings.letsGo),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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

class CategoryCard3D extends StatefulWidget {
  final CategoryModel category;
  final String locale;
  final VoidCallback onTap;
  final Color cardColor;

  const CategoryCard3D({
    super.key,
    required this.category,
    required this.locale,
    required this.onTap,
    required this.cardColor,
  });

  @override
  State<CategoryCard3D> createState() => _CategoryCard3DState();
}

class _CategoryCard3DState extends State<CategoryCard3D> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final category = widget.category;
    final locale = widget.locale;
    final cardColor = widget.cardColor;

    final hsl = HSLColor.fromColor(cardColor);
    final shadowColor = hsl.withLightness((hsl.lightness - 0.15).clamp(0.0, 1.0)).toColor();

    final bool hasLottie = category.lottiePath != null && category.lottiePath!.toLowerCase().contains('.json');

    final assetPath = hasLottie ? category.lottiePath! : (category.imagePath ?? '');

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
        HapticFeedback.lightImpact();
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        curve: Curves.easeOut,
        width: 170,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        transform: Matrix4.translationValues(0, _isPressed ? 6 : 0, 0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(28.0),
          border: Border.all(color: Colors.white, width: 4.0),
          boxShadow: [
            if (!_isPressed) ...[
              BoxShadow(color: shadowColor, offset: const Offset(0, 8)),
              BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 10)),
            ] else ...[
              BoxShadow(color: shadowColor, offset: const Offset(0, 2)),
            ],
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -15,
              top: -15,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.18)),
              ),
            ),
            Positioned(
              left: -20,
              bottom: -20,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.1)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Hero(
                        tag: 'cat_img_${category.id}',
                        child: CustomImage(pathOrUrl: assetPath, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    category.getTitle(locale: locale),
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    hasShadow: true,
                    shadowColor: Colors.black.withOpacity(0.25),
                    shadowOffset: 1.5,
                  ),
                ],
              ),
            ),
            if (category.isPremium)
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD93D),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 4, offset: const Offset(0, 2))],
                  ),
                  child: const Icon(Icons.star_rounded, size: 16, color: Color(0xFF7C5730)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
