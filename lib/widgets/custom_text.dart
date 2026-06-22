import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign textAlign;
  final bool hasShadow;
  final Color shadowColor;
  final double shadowOffset;
  final double shadowBlurRadius;
  final int? maxLines;
  final TextOverflow overflow;
  final double? letterSpacing;
  final double? height;

  const CustomText(
    this.text, {
    super.key,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.textAlign = TextAlign.start,
    this.hasShadow = false,
    this.shadowColor = const Color(0x33000000),
    this.shadowOffset = 2.0,
    this.shadowBlurRadius = 4.0,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.letterSpacing,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        letterSpacing: letterSpacing,
        height: height,
        shadows: hasShadow
            ? [
                Shadow(
                  color: shadowColor,
                  offset: Offset(shadowOffset, shadowOffset),
                  blurRadius: shadowBlurRadius,
                )
              ]
            : null,
      ),
    );
  }
}
