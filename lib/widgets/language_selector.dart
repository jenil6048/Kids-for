import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_text.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildLanguagePill(context, 'en', '🇬🇧 English'),
        const SizedBox(width: 10),
        _buildLanguagePill(context, 'gu', '🇮🇳 ગુજરાતી'),
        const SizedBox(width: 10),
        _buildLanguagePill(context, 'hi', '🇮🇳 हिन्दी'),
      ],
    );
  }

  Widget _buildLanguagePill(BuildContext context, String code, String label) {
    final isSelected = context.locale.languageCode == code;
    final primaryColor = isSelected ? const Color(0xFF4CAF50) : Colors.white;
    final shadowColor = isSelected ? const Color(0xFF2E7D32) : const Color(0xFFD7D3C5);

    return GestureDetector(
      onTap: () {
        context.setLocale(Locale(code));
        HapticFeedback.lightImpact();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.white : const Color(0xFFE0DCCF),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: CustomText(
          label,
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: isSelected ? Colors.white : const Color(0xFF7C5730),
        ),
      ),
    );
  }
}
