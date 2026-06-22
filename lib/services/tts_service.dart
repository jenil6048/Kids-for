import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  TtsService._internal();
  static final TtsService instance = TtsService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;

  bool get isSpeaking => _isSpeaking;

  Future<void> speak(String text, String languageCode) async {
    try {
      await stop();

      // Map language code to system TTS locale
      String locale = 'en-US';
      if (languageCode == 'gu') locale = 'gu-IN';
      if (languageCode == 'hi') locale = 'hi-IN';

      await _flutterTts.setLanguage(locale);
      await _flutterTts.setPitch(1.3); // High-pitched, cute voice for kids
      await _flutterTts.setSpeechRate(0.42); // Slow, clear rate for kids

      _flutterTts.setStartHandler(() {
        _isSpeaking = true;
      });

      _flutterTts.setCompletionHandler(() {
        _isSpeaking = false;
      });

      _flutterTts.setErrorHandler((msg) {
        _isSpeaking = false;
      });

      await _flutterTts.speak(text);
    } catch (_) {
      _isSpeaking = false;
    }
  }

  Future<void> stop() async {
    try {
      await _flutterTts.stop();
      _isSpeaking = false;
    } catch (_) {}
  }
}
