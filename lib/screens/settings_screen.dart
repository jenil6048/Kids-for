import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_strings.dart';
import '../repositories/auth_repository.dart';
import '../repositories/settings_repository.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_image.dart';
import 'login_screen.dart';
import '../widgets/edit_profile_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Mock configuration constants
  final String _contactEmail = 'support@kidsadventure.com';
  final String _contactWebsite = 'https://kidsadventure.com';
  final String _whatsappNumber = '919876543210'; // Simulated whatsapp number
  final String _privacyUrl = 'https://kidsadventure.com/privacy';
  final String _termsUrl = 'https://kidsadventure.com/terms';
  final String _playStoreUrl = 'https://play.google.com/store/apps/details?id=com.kidsfor.adventure';
  final String _appStoreUrl = 'https://apps.apple.com/app/kids-learning-adventure/id1234567890';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF1B2E1E), const Color(0xFF1A1A1A)]
                : [
                    const Color(0xFFE0F7FA), // Soft sky cyan
                    const Color(0xFFFFF9C4), // Warm pastel yellow
                    const Color(0xFFE8F5E9), // Soft mint green
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Row
              _buildHeader(context, isDark),

              // Settings Scrollable Content
              Expanded(
                child: ValueListenableBuilder<UserModel?>(
                  valueListenable: AuthRepository.instance.currentUserNotifier,
                  builder: (context, user, child) {
                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      children: [
                        // 1. Profile Section Card
                        if (user == null)
                          _buildGuestProfileCard(context, isDark)
                        else
                          _buildLoggedInProfileCard(context, user, isDark),

                        const SizedBox(height: 20),

                        // 2. App Preferences Card (Language, Sound, Dark Mode)
                        _buildPreferencesCard(context, isDark),

                        const SizedBox(height: 20),

                        // 3. Support & Action Card (Share, Contact, Privacy, Terms, Rate, About)
                        _buildSupportCard(context, isDark),

                        const SizedBox(height: 20),

                        // 4. Session Controls (Logout, Delete Account) - Logged in only
                        if (user != null) _buildSessionControlsCard(context, isDark),

                        const SizedBox(height: 40),
                      ],
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

  // --- UI Component Builders ---

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          // Bubbly back button
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDark ? Colors.black38 : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? Colors.grey.shade800 : const Color(0xFFE0DCCF),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.black54 : const Color(0xFFD7D3C5),
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: isDark ? Colors.white : const Color(0xFF7C5730),
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Bubbly Header title banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFC8E6C9), width: 3),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2E7D32).withOpacity(0.15),
                  offset: const Offset(0, 4),
                  blurRadius: 6,
                )
              ],
            ),
            child: CustomText(
              tr(AppStrings.settings),
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF2E7D32),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestProfileCard(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF9C4), Color(0xFFFFE082)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFB300).withOpacity(0.3),
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.face_unlock_rounded, size: 64, color: Color(0xFF7C5730)),
          const SizedBox(height: 12),
          CustomText(
            tr(AppStrings.welcome),
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF9E2A2B),
          ),
          const SizedBox(height: 8),
          CustomText(
            tr(AppStrings.syncProgress),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            color: const Color(0xFF7C5730),
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  backgroundColor: const Color(0xFF2E7D32),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Center(
                    child: CustomText(
                      tr(AppStrings.login),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  backgroundColor: const Color(0xFFFF9800),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Center(
                    child: CustomText(
                      tr(AppStrings.signUp),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLoggedInProfileCard(BuildContext context, UserModel user, bool isDark) {
    final hsl = HSLColor.fromColor(const Color(0xFFC8E6C9));
    final shadowColor = hsl.withLightness((hsl.lightness - 0.15).clamp(0.0, 1.0)).toColor();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF223A25) : const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: isDark ? const Color(0xFF2E7D32) : Colors.white,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black45 : shadowColor.withOpacity(0.5),
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Circular avatar
              Container(
                width: 72,
                height: 72,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFFFD93D), width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: ClipOval(
                  child: CustomImage(
                    pathOrUrl: user.avatarUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Name & Email
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: CustomText(
                            user.name,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: isDark ? Colors.white : const Color(0xFF2E7D32),
                          ),
                        ),
                        const SizedBox(width: 6),
                        // Provider Badge
                        _buildProviderBadge(user.provider),
                      ],
                    ),
                    const SizedBox(height: 2),
                    CustomText(
                      user.email,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.grey.shade400 : const Color(0xFF7C5730).withOpacity(0.8),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          // Edit Profile Button
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              backgroundColor: const Color(0xFF2E7D32),
              onPressed: () async {
                HapticFeedback.lightImpact();
                await showDialog(
                  context: context,
                  builder: (context) => EditProfileDialog(currentUser: user),
                );
              },
              child: Center(
                child: CustomText(
                  tr(AppStrings.editProfile),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProviderBadge(String provider) {
    IconData icon = Icons.email_rounded;
    Color color = Colors.blue;

    if (provider == 'google') {
      icon = Icons.g_mobiledata_rounded;
      color = Colors.red;
    } else if (provider == 'apple') {
      icon = Icons.apple_rounded;
      color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 16),
    );
  }

  Widget _buildPreferencesCard(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : const Color(0xFFE0DCCF),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black38 : const Color(0xFFD7D3C5).withOpacity(0.5),
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        children: [
          // Title
          _buildCardHeader('Preferences', Icons.tune_rounded, const Color(0xFF2E7D32), isDark),
          const Divider(height: 1, color: Color(0xFFE0DCCF)),

          // 1. Language Option
          ValueListenableBuilder<String>(
            valueListenable: SettingsRepository.instance.languageNotifier,
            builder: (context, currentLang, child) {
              String langName = '🇬🇧 English';
              if (currentLang == 'gu') langName = '🇮🇳 ગુજરાતી';
              if (currentLang == 'hi') langName = '🇮🇳 हिन्दी';

              return _buildListTile(
                title: tr(AppStrings.language),
                subtitle: langName,
                icon: Icons.language_rounded,
                iconColor: const Color(0xFF3F51B5),
                isDark: isDark,
                onTap: () => _showLanguageSelectorDialog(context),
              );
            },
          ),
          const Divider(height: 1, color: Color(0xFFE0DCCF)),

          // 2. Sound Switch Option
          ValueListenableBuilder<bool>(
            valueListenable: SettingsRepository.instance.soundNotifier,
            builder: (context, soundEnabled, child) {
              return _buildSwitchTile(
                title: tr(AppStrings.sound),
                value: soundEnabled,
                icon: Icons.volume_up_rounded,
                iconColor: const Color(0xFF00BCD4),
                isDark: isDark,
                onChanged: (val) {
                  HapticFeedback.lightImpact();
                  SettingsRepository.instance.setSoundEnabled(val);
                },
              );
            },
          ),
          const Divider(height: 1, color: Color(0xFFE0DCCF)),

          // 3. Dark Mode Option
          ValueListenableBuilder<bool>(
            valueListenable: SettingsRepository.instance.darkModeNotifier,
            builder: (context, darkModeEnabled, child) {
              return _buildSwitchTile(
                title: tr(AppStrings.darkMode),
                value: darkModeEnabled,
                icon: Icons.nights_stay_rounded,
                iconColor: const Color(0xFF9C27B0),
                isDark: isDark,
                onChanged: (val) {
                  HapticFeedback.lightImpact();
                  SettingsRepository.instance.setDarkModeEnabled(val);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : const Color(0xFFE0DCCF),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black38 : const Color(0xFFD7D3C5).withOpacity(0.5),
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        children: [
          _buildCardHeader('More Fun & Info', Icons.info_rounded, const Color(0xFFFF9800), isDark),
          const Divider(height: 1, color: Color(0xFFE0DCCF)),

          // Share Application
          _buildListTile(
            title: tr(AppStrings.shareApp),
            icon: Icons.share_rounded,
            iconColor: const Color(0xFFFF9800),
            isDark: isDark,
            onTap: _shareApplication,
          ),
          const Divider(height: 1, color: Color(0xFFE0DCCF)),

          // Contact Us
          _buildListTile(
            title: tr(AppStrings.contactUs),
            icon: Icons.chat_bubble_rounded,
            iconColor: const Color(0xFF4CAF50),
            isDark: isDark,
            onTap: () => _showContactOptions(context, isDark),
          ),
          const Divider(height: 1, color: Color(0xFFE0DCCF)),

          // Privacy Policy
          _buildListTile(
            title: tr(AppStrings.privacyPolicy),
            icon: Icons.security_rounded,
            iconColor: const Color(0xFFE91E63),
            isDark: isDark,
            onTap: () => _launchURL(_privacyUrl),
          ),
          const Divider(height: 1, color: Color(0xFFE0DCCF)),

          // Terms & Conditions
          _buildListTile(
            title: tr(AppStrings.termsConditions),
            icon: Icons.description_rounded,
            iconColor: const Color(0xFF9E2A2B),
            isDark: isDark,
            onTap: () => _launchURL(_termsUrl),
          ),
          const Divider(height: 1, color: Color(0xFFE0DCCF)),

          // Rate App
          _buildListTile(
            title: tr(AppStrings.rateApp),
            icon: Icons.star_rounded,
            iconColor: const Color(0xFFFFD93D),
            isDark: isDark,
            onTap: () => _launchURL(Platform.isIOS ? _appStoreUrl : _playStoreUrl),
          ),
          const Divider(height: 1, color: Color(0xFFE0DCCF)),

          // About App
          _buildListTile(
            title: tr(AppStrings.aboutApp),
            icon: Icons.emoji_nature_rounded,
            iconColor: const Color(0xFF2E7D32),
            isDark: isDark,
            onTap: () => _showAboutDialog(context, isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionControlsCard(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : const Color(0xFFE0DCCF),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black38 : const Color(0xFFD7D3C5).withOpacity(0.5),
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        children: [
          // Logout
          _buildListTile(
            title: tr(AppStrings.logout),
            icon: Icons.exit_to_app_rounded,
            iconColor: const Color(0xFFE53935),
            isDark: isDark,
            onTap: () => _showLogoutConfirmation(context, isDark),
          ),
          const Divider(height: 1, color: Color(0xFFE0DCCF)),

          // Delete Account
          _buildListTile(
            title: tr(AppStrings.deleteAccount),
            icon: Icons.delete_forever_rounded,
            iconColor: Colors.red.shade900,
            isDark: isDark,
            onTap: () => _showDeleteConfirmation(context, isDark),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildCardHeader(String title, IconData icon, Color color, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 8),
          CustomText(
            title,
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: isDark ? Colors.white : const Color(0xFF7C5730),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    String? subtitle,
    required IconData icon,
    required Color iconColor,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF7C5730),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    CustomText(
                      subtitle,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.grey : Colors.grey.shade600,
                    ),
                  ]
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: isDark ? Colors.grey : const Color(0xFF7C5730).withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required IconData icon,
    required Color iconColor,
    required bool isDark,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: CustomText(
              title,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF7C5730),
            ),
          ),
          Switch.adaptive(
            value: value,
            activeColor: const Color(0xFF2E7D32),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // --- Handlers & Dialogs ---

  void _shareApplication() {
    HapticFeedback.lightImpact();
    const message = "I'm learning with this amazing Kids Learning App!\nDownload it now.";
    Share.share(message);
  }

  Future<void> _launchURL(String urlString) async {
    HapticFeedback.lightImpact();
    final uri = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      // Fail silently or show dialog
    }
  }

  void _showLanguageSelectorDialog(BuildContext context) {
    HapticFeedback.mediumImpact();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F3E8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          side: const BorderSide(color: Color(0xFF2E7D32), width: 4),
        ),
        title: Center(
          child: CustomText(
            tr(AppStrings.language),
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: isDark ? Colors.white : const Color(0xFF9E2A2B),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageDialogItem(context, 'en', '🇬🇧 English'),
            const SizedBox(height: 8),
            _buildLanguageDialogItem(context, 'gu', '🇮🇳 ગુજરાતી'),
            const SizedBox(height: 8),
            _buildLanguageDialogItem(context, 'hi', '🇮🇳 हिन्दी'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageDialogItem(BuildContext context, String code, String label) {
    final isSelected = context.locale.languageCode == code;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        context.setLocale(Locale(code));
        SettingsRepository.instance.setLanguageCode(code);
        HapticFeedback.lightImpact();
        Navigator.of(context).pop();
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE8F5E9)
              : (isDark ? Colors.black12 : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFFE0DCCF),
            width: 2.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              label,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? const Color(0xFF2E7D32) : (isDark ? Colors.white : const Color(0xFF7C5730)),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32)),
          ],
        ),
      ),
    );
  }

  void _showContactOptions(BuildContext context, bool isDark) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F3E8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomText(
                    tr(AppStrings.contactUs),
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: isDark ? Colors.white : const Color(0xFF9E2A2B),
                  ),
                ),
                const SizedBox(height: 24),
                // Email button
                CustomButton(
                  backgroundColor: const Color(0xFF3F51B5),
                  onPressed: () {
                    Navigator.pop(context);
                    _launchURL('mailto:$_contactEmail?subject=Kids%20Learning%20App%20Feedback');
                  },
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email_rounded, color: Colors.white),
                        SizedBox(width: 10),
                        CustomText('Send Email', fontWeight: FontWeight.bold, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Website Button
                CustomButton(
                  backgroundColor: const Color(0xFFFF9800),
                  onPressed: () {
                    Navigator.pop(context);
                    _launchURL(_contactWebsite);
                  },
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.language_rounded, color: Colors.white),
                        SizedBox(width: 10),
                        CustomText('Visit Website', fontWeight: FontWeight.bold, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // WhatsApp Button
                CustomButton(
                  backgroundColor: const Color(0xFF4CAF50),
                  onPressed: () {
                    Navigator.pop(context);
                    // Open WhatsApp link
                    _launchURL('https://wa.me/$_whatsappNumber');
                  },
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_rounded, color: Colors.white),
                        SizedBox(width: 10),
                        CustomText('Chat on WhatsApp', fontWeight: FontWeight.bold, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context, bool isDark) {
    HapticFeedback.lightImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F3E8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          side: const BorderSide(color: Color(0xFF2E7D32), width: 4),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // App Logo
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: const Color(0xFFFFD93D), width: 3),
              ),
              child: const ClipOval(
                child: CustomImage(
                  pathOrUrl: 'assets/images/lion_explorer.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomText(
              tr(AppStrings.appTitle),
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : const Color(0xFF9E2A2B),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            CustomText(
              'Version 1.0.0 (Build 1)',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.grey : const Color(0xFF7C5730),
            ),
            const SizedBox(height: 4),
            CustomText(
              'Developer: Jenil Shiroya',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.grey : const Color(0xFF7C5730),
            ),
            const SizedBox(height: 12),
            CustomText(
              '© 2026 Kids Learning Adventure.\nAll rights reserved.',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
            ),
            const SizedBox(height: 20),
            CustomButton(
              backgroundColor: const Color(0xFF2E7D32),
              onPressed: () => Navigator.pop(context),
              child: const CustomText(
                'Great! 🚀',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context, bool isDark) {
    HapticFeedback.mediumImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F3E8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          side: const BorderSide(color: Color(0xFFE53935), width: 4),
        ),
        title: Center(
          child: CustomText(
            tr(AppStrings.logout),
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: const Color(0xFFE53935),
          ),
        ),
        content: CustomText(
          tr(AppStrings.logoutConfirm),
          fontSize: 16,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
          color: isDark ? Colors.white : const Color(0xFF7C5730),
          maxLines: 3,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          CustomButton(
            backgroundColor: Colors.grey.shade400,
            onPressed: () => Navigator.of(context).pop(),
            child: CustomText(
              tr(AppStrings.cancel),
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          CustomButton(
            backgroundColor: const Color(0xFFE53935),
            onPressed: () async {
              Navigator.of(context).pop();
              await AuthRepository.instance.logout();
            },
            child: CustomText(
              tr(AppStrings.logout),
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, bool isDark) {
    HapticFeedback.heavyImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F3E8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          side: BorderSide(color: Colors.red.shade900, width: 4),
        ),
        title: Center(
          child: CustomText(
            tr(AppStrings.deleteAccount),
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.red.shade900,
          ),
        ),
        content: CustomText(
          tr(AppStrings.deleteConfirm),
          fontSize: 16,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
          color: isDark ? Colors.white : const Color(0xFF7C5730),
          maxLines: 3,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          CustomButton(
            backgroundColor: Colors.grey.shade400,
            onPressed: () => Navigator.of(context).pop(),
            child: CustomText(
              tr(AppStrings.cancel),
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          CustomButton(
            backgroundColor: Colors.red.shade900,
            onPressed: () async {
              Navigator.of(context).pop();
              await AuthRepository.instance.deleteAccount();
            },
            child: CustomText(
              tr(AppStrings.delete),
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
