import 'package:flutter_tts/flutter_tts.dart';
import '../repositories/settings_repository.dart';

class TtsService {
  TtsService._internal();
  static final TtsService instance = TtsService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;

  bool get isSpeaking => _isSpeaking;

  /// Warm up and initialize the native TTS engine.
  Future<void> init() async {
    try {
      await _flutterTts.setLanguage('en-US');
      await _flutterTts.setPitch(1.3);
      await _flutterTts.setSpeechRate(0.42);
      // Play a silent space character to force the OS to bind to the TTS service in background
      await _flutterTts.speak(" ");
    } catch (_) {}
  }

  Future<void> speak(String text, String languageCode) async {
    if (!SettingsRepository.instance.isSoundEnabled) {
      return;
    }
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
