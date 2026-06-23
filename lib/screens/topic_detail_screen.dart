import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/topic_model.dart';
import '../services/supabase_service.dart';
import '../services/tts_service.dart';
import '../widgets/custom_image.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_loading.dart';

// ==========================================
// KID CLOUD CARD WIDGET
// ==========================================
class KidCloudCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double borderRadius;
  final double borderWidth;
  final Color? borderColor;
  final double shadowOffset;

  const KidCloudCard({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.borderRadius = 24.0,
    this.borderWidth = 0.0,
    this.borderColor,
    this.shadowOffset = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: shadowOffset * 2.0,
            offset: Offset(0, shadowOffset),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: child,
      ),
    );
  }
}

// ==========================================
// CATEGORY TOPICS SLIDER SCREEN
// ==========================================
class CategoryTopicsScreen extends StatefulWidget {
  final CategoryModel category;
  final String activeLanguage;

  const CategoryTopicsScreen({
    super.key,
    required this.category,
    required this.activeLanguage,
  });

  @override
  State<CategoryTopicsScreen> createState() => _CategoryTopicsScreenState();
}

class _CategoryTopicsScreenState extends State<CategoryTopicsScreen> with SingleTickerProviderStateMixin {
  final SupabaseService _supabaseService = SupabaseService.instance;
  late Future<List<TopicModel>> _topicsFuture;
  late PageController _pageController;
  int _currentPage = 0;
  bool _isGridView = true; // Toggle between Grid and Slider

  late AnimationController _bgAnimationController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _topicsFuture = _supabaseService.getTopicsForCategory(
      widget.category.categoryKey,
      widget.category.id,
    );

    _bgAnimationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _bgAnimationController.dispose();
    TtsService.instance.stop();
    super.dispose();
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
      return colorVal != null ? Color(colorVal) : const Color(0xFF2E7D32);
    } catch (_) {
      return const Color(0xFF2E7D32);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = _parseHexColor(widget.category.color);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: CustomText(
          widget.category.getTitle(locale: widget.activeLanguage),
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          hasShadow: true,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.white.withOpacity(0.3),
            borderRadius: 12,
            elevation: 0,
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 28),
          ),
        ),
        actions: [
          // View Toggle Button
          FutureBuilder<List<TopicModel>>(
            future: _topicsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  child: CustomButton(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: Colors.white.withOpacity(0.3),
                    borderRadius: 12,
                    elevation: 0,
                    onPressed: () {
                      setState(() {
                        _isGridView = !_isGridView;
                        if (!_isGridView) {
                          _pageController = PageController(initialPage: _currentPage);
                        }
                      });
                    },
                    child: Icon(
                      _isGridView ? Icons.view_carousel_rounded : Icons.grid_view_rounded,
                      color: Colors.white,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          FutureBuilder<List<TopicModel>>(
            future: _topicsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final total = snapshot.data!.length;
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0, top: 8, bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomText(
                      '${_currentPage + 1} / $total',
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Playful Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themeColor,
                  themeColor.withOpacity(0.7),
                  const Color(0xFFF8F9FE),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.3, 0.6],
              ),
            ),
          ),
          
          // Animated Background Shapes
          AnimatedBuilder(
            animation: _bgAnimationController,
            builder: (context, child) {
              return Stack(
                children: [
                  _buildAnimatedShape(
                    top: 100 + 20 * math.sin(_bgAnimationController.value * 2 * math.pi),
                    left: -20,
                    size: 100,
                    color: Colors.white.withOpacity(0.1),
                  ),
                  _buildAnimatedShape(
                    top: 250 + 30 * math.cos(_bgAnimationController.value * 2 * math.pi),
                    right: -30,
                    size: 150,
                    color: Colors.white.withOpacity(0.05),
                  ),
                  _buildAnimatedShape(
                    bottom: 100 + 20 * math.sin(_bgAnimationController.value * 2 * math.pi + math.pi),
                    left: 50,
                    size: 80,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ],
              );
            },
          ),

          SafeArea(
            child: FutureBuilder<List<TopicModel>>(
              future: _topicsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) => const CustomLoading(borderRadius: 24),
                  );
                }

                if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: KidCloudCard(
                      borderRadius: 32,
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.sentiment_dissatisfied_rounded, size: 80, color: Colors.orange),
                            const SizedBox(height: 20),
                            CustomText(
                              'Oops! No lessons found.',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF7C5730),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                final topics = snapshot.data!;

                if (_isGridView) {
                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: topics.length,
                    itemBuilder: (context, index) {
                      final topic = topics[index];
                      final imgPath = (topic.svgPath != null && topic.svgPath!.isNotEmpty)
                          ? topic.svgPath!
                          : (topic.lottiePath ?? (topic.imagePath ?? ''));

                      return CustomButton(
                        padding: const EdgeInsets.all(4),
                        backgroundColor: Colors.white,
                        borderRadius: 24,
                        elevation: 6,
                        borderColor: themeColor.withOpacity(0.2),
                        borderWidth: 2,
                        onPressed: () {
                          setState(() {
                            _currentPage = index;
                            _isGridView = false;
                            _pageController = PageController(initialPage: index);
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: themeColor.withOpacity(0.05),
                                  shape: BoxShape.circle,
                                ),
                                child: CustomImage(
                                  pathOrUrl: imgPath,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: themeColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: CustomText(
                                topic.getName(locale: widget.activeLanguage),
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: themeColor,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                return PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: topics.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final topic = topics[index];
                    return TopicDetailScreen(
                      topic: topic,
                      category: widget.category,
                      activeLanguage: widget.activeLanguage,
                      embedInPageView: true,
                      isActive: _currentPage == index,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedShape({double? top, double? left, double? right, double? bottom, required double size, required Color color}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// ==========================================
// TOPIC DETAIL SCREEN (INDIVIDUAL ITEM)
// ==========================================
class TopicDetailScreen extends StatefulWidget {
  final TopicModel topic;
  final CategoryModel category;
  final String activeLanguage;
  final bool embedInPageView;
  final bool isActive;

  const TopicDetailScreen({
    super.key,
    required this.topic,
    required this.category,
    required this.activeLanguage,
    this.embedInPageView = false,
    this.isActive = true,
  });

  @override
  State<TopicDetailScreen> createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<TopicDetailScreen> with SingleTickerProviderStateMixin {
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      _playNarration();
    }
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TopicDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _playNarration();
    }
  }

  void _playNarration() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final title = widget.topic.getName(locale: widget.activeLanguage);
      final narration = widget.topic.getNarration(locale: widget.activeLanguage);
      final String speechText = "$title. $narration";
      TtsService.instance.speak(speechText, widget.activeLanguage);
    });
  }

  void _playFact() {
    final fact = widget.topic.getFact(locale: widget.activeLanguage);
    TtsService.instance.speak(fact, widget.activeLanguage);
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
      return colorVal != null ? Color(colorVal) : const Color(0xFF2E7D32);
    } catch (_) {
      return const Color(0xFF2E7D32);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = _parseHexColor(widget.category.color);
    final title = widget.topic.getName(locale: widget.activeLanguage);
    final narration = widget.topic.getNarration(locale: widget.activeLanguage);
    final explanation = widget.topic.getExplanation(locale: widget.activeLanguage);
    final fact = widget.topic.getFact(locale: widget.activeLanguage);

    final imagePath = (widget.topic.lottiePath != null && widget.topic.lottiePath!.isNotEmpty)
        ? widget.topic.lottiePath!
        : ((widget.topic.svgPath != null && widget.topic.svgPath!.isNotEmpty)
            ? widget.topic.svgPath!
            : (widget.topic.imagePath ?? ''));

    Widget content = Stack(
      children: [
        if (widget.embedInPageView)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    themeColor.withOpacity(0.05),
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            24,
            widget.embedInPageView ? 16 : 16,
            24,
            widget.embedInPageView ? 120 : 24,
          ),
          child: Column(
            children: [
              // Header Cloud Card
              KidCloudCard(
                backgroundColor: themeColor,
                borderRadius: 24,
                shadowOffset: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      const SizedBox(width: 40),
                      Expanded(
                        child: CustomText(
                          title,
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          hasShadow: true,
                        ),
                      ),
                      CustomButton(
                        padding: const EdgeInsets.all(10),
                        backgroundColor: Colors.white,
                        borderRadius: 100,
                        elevation: 2,
                        onPressed: _playNarration,
                        child: Icon(
                          Icons.volume_up_rounded,
                          color: themeColor,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              // Centered floating illustration
              AnimatedBuilder(
                animation: _floatController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, 10 * math.sin(_floatController.value * 2 * math.pi)),
                    child: child,
                  );
                },
                child: Center(
                  child: Hero(
                    tag: 'topic_illustration_${widget.topic.id}',
                    child: Container(
                      width: 200,
                      height: 200,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: themeColor.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        border: Border.all(color: themeColor.withOpacity(0.3), width: 6),
                      ),
                      child: ClipOval(
                        child: CustomImage(
                          pathOrUrl: imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Explanation Card
              KidCloudCard(
                borderRadius: 28,
                borderColor: themeColor.withOpacity(0.1),
                borderWidth: 2,
                shadowOffset: 5,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: themeColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.auto_stories_rounded, color: themeColor, size: 22),
                          ),
                          const SizedBox(width: 12),
                          CustomText(
                            widget.activeLanguage == 'gu'
                                ? 'અભ્યાસ વિશે'
                                : (widget.activeLanguage == 'hi' ? 'पाठ के बारे में' : 'About Lesson'),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: themeColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomText(
                        narration,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        maxLines: 4,
                        height: 1.3,
                      ),
                      const SizedBox(height: 12),
                      CustomText(
                        explanation,
                        fontSize: 16,
                        color: Colors.grey.shade700,
                        maxLines: 10,
                        height: 1.4,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Fact Card
              CustomButton(
                padding: EdgeInsets.zero,
                onPressed: _playFact,
                borderRadius: 28,
                elevation: 4,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [const Color(0xFFFF9800), const Color(0xFFFFC107)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.lightbulb_rounded, color: Colors.white, size: 30),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              widget.activeLanguage == 'gu'
                                  ? 'શું તમે જાણો છો?'
                                  : (widget.activeLanguage == 'hi' ? 'क्या आपको पता है?' : 'DID YOU KNOW?'),
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              letterSpacing: 1,
                            ),
                            const SizedBox(height: 6),
                            CustomText(
                              fact,
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              maxLines: 4,
                              height: 1.3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      context,
                      label: widget.activeLanguage == 'gu' ? 'રમતો' : (widget.activeLanguage == 'hi' ? 'खेल' : 'PLAY'),
                      icon: Icons.sports_esports_rounded,
                      colors: [const Color(0xFF6366F1), const Color(0xFF4F46E5)],
                      onPressed: () => _launchGameScreen(context, widget.topic, themeColor),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildActionButton(
                      context,
                      label: widget.activeLanguage == 'gu' ? 'ક્વિઝ' : (widget.activeLanguage == 'hi' ? 'ક્વિઝ' : 'QUIZ'),
                      icon: Icons.quiz_rounded,
                      colors: [const Color(0xFFEC4899), const Color(0xFFD946EF)],
                      onPressed: () => _launchQuizScreen(context, widget.topic, themeColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    if (widget.embedInPageView) {
      return content;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: CustomText(title, fontWeight: FontWeight.w900, color: Colors.white, hasShadow: true),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [themeColor, themeColor.withOpacity(0.0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(child: content),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, {required String label, required IconData icon, required List<Color> colors, required VoidCallback onPressed}) {
    return CustomButton(
      gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
      borderRadius: 24,
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(vertical: 16),
      elevation: 6,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 6),
          CustomText(
            label,
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ],
      ),
    );
  }

  void _launchGameScreen(BuildContext context, TopicModel topic, Color themeColor) {
    TtsService.instance.stop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KidsGameScreen(
          topic: topic,
          themeColor: themeColor,
          activeLanguage: widget.activeLanguage,
          onCompleted: () {
            _showCompletionDialog(context, themeColor);
          },
        ),
      ),
    );
  }

  void _launchQuizScreen(BuildContext context, TopicModel topic, Color themeColor) {
    TtsService.instance.stop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KidsQuizScreen(
          topic: topic,
          themeColor: themeColor,
          activeLanguage: widget.activeLanguage,
          onCompleted: () {
            _showCompletionDialog(context, themeColor);
          },
        ),
      ),
    );
  }

  void _showCompletionDialog(BuildContext context, Color themeColor) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: KidCloudCard(
            borderRadius: 36,
            borderColor: themeColor.withOpacity(0.3),
            borderWidth: 4,
            shadowOffset: 8,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Icon(
                        Icons.stars_rounded,
                        color: Colors.amber,
                        size: 80,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomText(
                    widget.activeLanguage == 'gu' ? 'અદ્ભુત!' : (widget.activeLanguage == 'hi' ? 'बहुत बढ़िया!' : 'AWESOME!'),
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: themeColor,
                  ),
                  const SizedBox(height: 12),
                  CustomText(
                    widget.activeLanguage == 'gu'
                        ? 'તમે આ સાહસ પૂર્ણ કર્યું છે અને તારાઓ કમાયા છે! 🌟'
                        : (widget.activeLanguage == 'hi' ? 'आपने यह खोज पूरी कर ली है और सितारे अर्जित किए हैं! 🌟' : 'You completed this adventure and earned stars! 🌟'),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: 160,
                    child: CustomButton(
                      gradient: const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF059669)]),
                      borderRadius: 24,
                      onPressed: () {
                        Navigator.pop(dialogContext); // dismiss dialog
                      },
                      child: CustomText(
                        widget.activeLanguage == 'gu' ? 'વાહ!' : (widget.activeLanguage == 'hi' ? 'वाह!' : 'Yay!'),
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ==========================================
// INTERACTIVE KIDS MINI GAME SCREEN
// ==========================================
class KidsGameScreen extends StatefulWidget {
  final TopicModel topic;
  final Color themeColor;
  final String activeLanguage;
  final VoidCallback onCompleted;

  const KidsGameScreen({
    super.key,
    required this.topic,
    required this.themeColor,
    required this.activeLanguage,
    required this.onCompleted,
  });

  @override
  State<KidsGameScreen> createState() => _KidsGameScreenState();
}

class _KidsGameScreenState extends State<KidsGameScreen> {
  // Game state
  List<String> _memoryCards = [];
  List<bool> _cardFlipped = [];
  List<bool> _cardMatched = [];
  int _firstFlippedIndex = -1;
  bool _busy = false;

  // Matching game state
  int _selectedLeft = -1;
  int _selectedRight = -1;
  List<bool> _matchedPairs = [false, false, false];

  // Puzzle state (degrees rotation for 4 quadrants)
  List<int> _puzzleRotations = [90, 180, 270, 90];

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  void _initGame() {
    if (widget.topic.gameType == 'memory') {
      // 4 cards (2 pairs: Star and Heart)
      _memoryCards = ['🌟', '❤️', '🌟', '❤️'];
      _memoryCards.shuffle();
      _cardFlipped = List.generate(4, (_) => false);
      _cardMatched = List.generate(4, (_) => false);
    }
  }

  void _onCardTap(int index) {
    if (_busy || _cardFlipped[index] || _cardMatched[index]) return;

    setState(() {
      _cardFlipped[index] = true;
    });

    if (_firstFlippedIndex == -1) {
      _firstFlippedIndex = index;
    } else {
      _busy = true;
      if (_memoryCards[_firstFlippedIndex] == _memoryCards[index]) {
        // Match!
        setState(() {
          _cardMatched[_firstFlippedIndex] = true;
          _cardMatched[index] = true;
          _busy = false;
          _firstFlippedIndex = -1;
        });
        _checkGameCompletion();
      } else {
        // No match
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) {
            setState(() {
              _cardFlipped[_firstFlippedIndex] = false;
              _cardFlipped[index] = false;
              _busy = false;
              _firstFlippedIndex = -1;
            });
          }
        });
      }
    }
  }

  void _onLeftItemTap(int index) {
    if (_matchedPairs[index]) return;
    setState(() {
      _selectedLeft = index;
    });
    _checkMatchingSelection();
  }

  void _onRightItemTap(int index) {
    // Correct matches: Left 0 matches Right 1, Left 1 matches Right 2, Left 2 matches Right 0 (shuffled match)
    // For simplicity, let's say index is matching directly: Left index matches Right index
    if (_matchedPairs[index]) return;
    setState(() {
      _selectedRight = index;
    });
    _checkMatchingSelection();
  }

  void _checkMatchingSelection() {
    if (_selectedLeft != -1 && _selectedRight != -1) {
      if (_selectedLeft == _selectedRight) {
        // Match!
        setState(() {
          _matchedPairs[_selectedLeft] = true;
          _selectedLeft = -1;
          _selectedRight = -1;
        });
        _checkGameCompletion();
      } else {
        // Not a match, reset selection after delay
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              _selectedLeft = -1;
              _selectedRight = -1;
            });
          }
        });
      }
    }
  }

  void _onPuzzlePieceTap(int index) {
    setState(() {
      _puzzleRotations[index] = (_puzzleRotations[index] + 90) % 360;
    });
    _checkGameCompletion();
  }

  void _checkGameCompletion() {
    bool isCompleted = false;

    if (widget.topic.gameType == 'memory') {
      isCompleted = _cardMatched.every((element) => element == true);
    } else if (widget.topic.gameType == 'matching') {
      isCompleted = _matchedPairs.every((element) => element == true);
    } else {
      // puzzle
      isCompleted = _puzzleRotations.every((rotation) => rotation == 0);
    }

    if (isCompleted) {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          Navigator.pop(context); // Go back to details
          widget.onCompleted();   // Show stars modal
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.topic.getName(locale: widget.activeLanguage);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3E8),
      appBar: AppBar(
        title: CustomText(
          '${widget.topic.gameType.toUpperCase()} - $title',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18,
        ),
        backgroundColor: widget.themeColor,
        leading: CustomButton(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                widget.topic.gameType == 'memory'
                    ? (widget.activeLanguage == 'gu'
                        ? 'બે સરખા કાર્ડ શોધો! 🃏'
                        : (widget.activeLanguage == 'hi' ? 'दो समान कार्ड खोजें! 🃏' : 'Find the matching pairs! 🃏'))
                    : (widget.topic.gameType == 'matching'
                        ? (widget.activeLanguage == 'gu'
                            ? 'નામ અને આકૃતિ મેળવો! 🔗'
                            : (widget.activeLanguage == 'hi' ? 'नाम और आकृति का मिलान करें! 🔗' : 'Match Name and Shape! 🔗'))
                        : (widget.activeLanguage == 'gu'
                            ? 'કોયડો ઉકેલવા માટે ટુકડા ફેરવો! 🧩'
                            : (widget.activeLanguage == 'hi' ? 'पहेली सुलझाने के लिए टुकड़ों को घुमाएं! 🧩' : 'Tap to rotate and solve puzzle! 🧩'))),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF7C5730),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // GAME INTERFACES
              Expanded(
                child: Center(
                  child: _buildGameContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameContent() {
    if (widget.topic.gameType == 'memory') {
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          final isFlipped = _cardFlipped[index] || _cardMatched[index];
          return CustomButton(
            padding: EdgeInsets.zero,
            borderRadius: 24,
            backgroundColor: isFlipped ? widget.themeColor.withOpacity(0.2) : widget.themeColor,
            elevation: 4,
            onPressed: () => _onCardTap(index),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isFlipped
                  ? Center(
                      child: CustomText(
                        _memoryCards[index],
                        fontSize: 48,
                      ),
                    )
                  : const Center(
                      child: Icon(
                        Icons.question_mark_rounded,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
            ),
          );
        },
      );
    } else if (widget.topic.gameType == 'matching') {
      // 3 items to match
      final leftItems = [
        widget.topic.getName(locale: widget.activeLanguage),
        widget.activeLanguage == 'gu' ? 'મિત્ર' : (widget.activeLanguage == 'hi' ? 'मित्र' : 'Friend'),
        widget.activeLanguage == 'gu' ? 'જંગલ' : (widget.activeLanguage == 'hi' ? 'जंगल' : 'Jungle')
      ];
      final rightIcons = [
        Icons.face_rounded,
        Icons.group_rounded,
        Icons.forest_rounded
      ];

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Left side list
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              final isMatched = _matchedPairs[index];
              final isSelected = _selectedLeft == index;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: CustomButton(
                  backgroundColor: isMatched
                      ? Colors.green.shade400
                      : (isSelected ? widget.themeColor : Colors.white),
                  borderRadius: 16,
                  elevation: 2,
                  onPressed: () => _onLeftItemTap(index),
                  child: SizedBox(
                    width: 110,
                    child: CustomText(
                      leftItems[index],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isMatched || isSelected ? Colors.white : const Color(0xFF7C5730),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }),
          ),
          // Connection connector icon
          Icon(Icons.compare_arrows_rounded, color: widget.themeColor.withOpacity(0.5), size: 36),
          // Right side list
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              final isMatched = _matchedPairs[index];
              final isSelected = _selectedRight == index;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: CustomButton(
                  backgroundColor: isMatched
                      ? Colors.green.shade400
                      : (isSelected ? widget.themeColor : Colors.white),
                  borderRadius: 16,
                  elevation: 2,
                  onPressed: () => _onRightItemTap(index),
                  child: SizedBox(
                    width: 60,
                    height: 44,
                    child: Icon(
                      rightIcons[index],
                      color: isMatched || isSelected ? Colors.white : widget.themeColor,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      );
    } else {
      // puzzle (grid of 4 rotated parts)
      final lottieOrImagePath = (widget.topic.lottiePath != null && widget.topic.lottiePath!.isNotEmpty)
          ? widget.topic.lottiePath!
          : ((widget.topic.svgPath != null && widget.topic.svgPath!.isNotEmpty)
              ? widget.topic.svgPath!
              : (widget.topic.imagePath ?? ''));

      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          final rotationDegree = _puzzleRotations[index];
          return KidCloudCard(
            borderRadius: 24,
            borderColor: rotationDegree == 0 ? Colors.green : Colors.grey.shade300,
            borderWidth: rotationDegree == 0 ? 4.0 : 1.5,
            child: InkWell(
              onTap: () => _onPuzzlePieceTap(index),
              child: AnimatedRotation(
                turns: rotationDegree / 360,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                  child: ClipRect(
                    child: Align(
                      // Crop to quadrants
                      alignment: index == 0
                          ? Alignment.topLeft
                          : (index == 1
                              ? Alignment.topRight
                              : (index == 2 ? Alignment.bottomLeft : Alignment.bottomRight)),
                      widthFactor: 2.0,
                      heightFactor: 2.0,
                      child: CustomImage(
                        pathOrUrl: lottieOrImagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}

// ==========================================
// PLAYFUL INTERACTIVE KIDS QUIZ SCREEN
// ==========================================
class KidsQuizScreen extends StatefulWidget {
  final TopicModel topic;
  final Color themeColor;
  final String activeLanguage;
  final VoidCallback onCompleted;

  const KidsQuizScreen({
    super.key,
    required this.topic,
    required this.themeColor,
    required this.activeLanguage,
    required this.onCompleted,
  });

  @override
  State<KidsQuizScreen> createState() => _KidsQuizScreenState();
}

class _KidsQuizScreenState extends State<KidsQuizScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  bool _answered = false;

  late List<Map<String, dynamic>> _questions;

  @override
  void initState() {
    super.initState();
    _initQuiz();
  }

  void _initQuiz() {
    // Multi-language questions tailored to the topic
    final title = widget.topic.getName(locale: widget.activeLanguage);

    _questions = [
      {
        'question': {
          'en': 'Is $title a friendly explorer in the jungle?',
          'gu': 'શું $title જંગલમાં એક મૈત્રીપૂર્ણ સંશોધક છે?',
          'hi': 'क्या $title जंगल में एक अनुकूल खोजकर्ता है?'
        },
        'options': [
          {'en': 'Yes, absolutely! 🦁', 'gu': 'હા, ચોક્કસ! 🦁', 'hi': 'हाँ, बिल्कुल! 🦁'},
          {'en': 'No, not at all ❌', 'gu': 'ના, બિલકુલ નહિ ❌', 'hi': 'नहीं, बिल्कुल नहीं ❌'},
        ],
        'answer': 0
      },
      {
        'question': {
          'en': 'What does $title love to explore?',
          'gu': '$title ને શું શોધવું ગમે છે?',
          'hi': '$title को क्या खोजना पसंद है?'
        },
        'options': [
          {'en': 'Computers 💻', 'gu': 'કમ્પ્યુટર્સ 💻', 'hi': 'कंप्यूटर 💻'},
          {'en': 'The Jungle! 🌳', 'gu': 'જંગલ! 🌳', 'hi': 'जंगल! 🌳'},
          {'en': 'Cities 🏢', 'gu': 'શહેરો 🏢', 'hi': 'शहर 🏢'},
        ],
        'answer': 1
      },
      {
        'question': {
          'en': 'What are we earning during this learning adventure?',
          'gu': 'આ શીખવાની સફર દરમિયાન આપણે શું મેળવી રહ્યા છીએ?',
          'hi': 'इस सीखने की यात्रा के दौरान हम क्या कमा रहे हैं?'
        },
        'options': [
          {'en': 'Gold Coins 🪙', 'gu': 'સોનાના સિક્કા 🪙', 'hi': 'सोने के सिक्के 🪙'},
          {'en': 'Shiny Stars! 🌟', 'gu': 'ચમકતા તારા! 🌟', 'hi': 'चमकते सितारे! 🌟'},
        ],
        'answer': 1
      }
    ];
  }

  void _onAnswerSelected(int index) {
    if (_answered) return;
    setState(() {
      _selectedAnswerIndex = index;
      _answered = true;
    });

    final isCorrect = index == _questions[_currentQuestionIndex]['answer'];
    if (isCorrect) {
      TtsService.instance.speak(
        widget.activeLanguage == 'gu' ? 'સાચો જવાબ! ખુબ સરસ!' : (widget.activeLanguage == 'hi' ? 'सही उत्तर! बहुत अच्छे!' : 'Correct! Great job!'),
        widget.activeLanguage,
      );
    } else {
      TtsService.instance.speak(
        widget.activeLanguage == 'gu' ? 'ફરી પ્રયાસ કરો' : (widget.activeLanguage == 'hi' ? 'पुनः प्रयास करें' : 'Try again'),
        widget.activeLanguage,
      );
    }

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        if (_currentQuestionIndex < _questions.length - 1) {
          setState(() {
            _currentQuestionIndex++;
            _selectedAnswerIndex = null;
            _answered = false;
          });
        } else {
          Navigator.pop(context); // Go back
          widget.onCompleted();   // Show stars completed
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQ = _questions[_currentQuestionIndex];
    final questionText = (currentQ['question'] as Map<String, String>)[widget.activeLanguage] ?? '';
    final optionsList = currentQ['options'] as List<Map<String, String>>;
    final correctAnswerIndex = currentQ['answer'] as int;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3E8),
      appBar: AppBar(
        title: CustomText(
          widget.activeLanguage == 'gu' ? 'સાહસ ક્વિઝ' : (widget.activeLanguage == 'hi' ? 'साहसिक प्रश्नोत्तरी' : 'Adventure Quiz'),
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18,
        ),
        backgroundColor: widget.themeColor,
        leading: CustomButton(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Question Progress bar
              Container(
                height: 12,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (_currentQuestionIndex + 1) / _questions.length,
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.themeColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Question bubble card
              KidCloudCard(
                borderRadius: 24,
                shadowOffset: 4,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const Icon(Icons.help_center_rounded, color: Colors.orange, size: 48),
                      const SizedBox(height: 16),
                      CustomText(
                        questionText,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF7C5730),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // Options
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: optionsList.length,
                  itemBuilder: (context, index) {
                    final optionText = optionsList[index][widget.activeLanguage] ?? '';
                    Color btnColor = Colors.white;
                    Color txtColor = const Color(0xFF7C5730);

                    if (_answered) {
                      if (index == correctAnswerIndex) {
                        btnColor = Colors.green.shade400;
                        txtColor = Colors.white;
                      } else if (index == _selectedAnswerIndex) {
                        btnColor = Colors.red.shade400;
                        txtColor = Colors.white;
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomButton(
                        backgroundColor: btnColor,
                        borderRadius: 20,
                        elevation: 3,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        onPressed: () => _onAnswerSelected(index),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _answered && index == correctAnswerIndex
                                    ? Colors.white.withOpacity(0.3)
                                    : widget.themeColor.withOpacity(0.1),
                              ),
                              child: Center(
                                child: CustomText(
                                  String.fromCharCode(65 + index), // A, B, C
                                  fontWeight: FontWeight.w900,
                                  color: _answered && index == correctAnswerIndex
                                      ? Colors.white
                                      : widget.themeColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomText(
                                optionText,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: txtColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
