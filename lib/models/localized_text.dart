class LocalizedText {
  final String en;
  final String gu;
  final String hi;

  LocalizedText({
    required this.en,
    required this.gu,
    required this.hi,
  });

  factory LocalizedText.fromJson(Map<String, dynamic> json) {
    return LocalizedText(
      en: json['en']?.toString() ?? '',
      gu: json['gu']?.toString() ?? '',
      hi: json['hi']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'en': en,
      'gu': gu,
      'hi': hi,
    };
  }

  /// Get text based on language code, defaulting to English if the translation is empty.
  String get(String languageCode) {
    switch (languageCode) {
      case 'gu':
        return gu.isNotEmpty ? gu : (en.isNotEmpty ? en : hi);
      case 'hi':
        return hi.isNotEmpty ? hi : (en.isNotEmpty ? en : gu);
      case 'en':
      default:
        return en.isNotEmpty ? en : (gu.isNotEmpty ? gu : hi);
    }
  }

  @override
  String toString() {
    return get('en');
  }
}
