import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'config/env_config.dart';
import 'hive/hive_service.dart';
import 'repositories/settings_repository.dart';
import 'repositories/auth_repository.dart';
import 'services/tts_service.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();


  // // 2. Seed / read Supabase credentials from secure storage
  await EnvConfig.seed();
  final supabaseUrl = await EnvConfig.supabaseUrl;
  final supabaseKey = await EnvConfig.supabaseKey;

  // // 3. Initialise Supabase
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  // 1. Initialise Hive (local database)
  await HiveService.instance.init();
  SettingsRepository.instance.init();
  AuthRepository.instance.init();
  TtsService.instance.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('gu'), Locale('hi')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: SettingsRepository.instance.darkModeNotifier,
      builder: (context, isDark, child) {
        return MaterialApp(
          title: 'Kids Learning Adventure',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2E7D32),
              primary: const Color(0xFF2E7D32),
              secondary: const Color(0xFFFFD93D),
              brightness: Brightness.light,
            ),
            useMaterial3: true,
            fontFamily: 'Inter',
            scaffoldBackgroundColor: const Color(0xFFF5F3E8),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2E7D32),
              primary: const Color(0xFF2E7D32),
              secondary: const Color(0xFFFFD93D),
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
            fontFamily: 'Inter',
            scaffoldBackgroundColor: const Color(0xFF1E1E1E),
          ),
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          home: const AppWrapper(),
        );
      },
    );
  }
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  bool _showSplash = true;

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return SplashScreen(
        onComplete: () {
          if (mounted) {
            setState(() {
              _showSplash = false;
            });
          }
        },
      );
    }
    return const HomeScreen();
  }
}
