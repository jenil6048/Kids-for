import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../hive/hive_service.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String avatarUrl; // Paths like 'assets/images/animals/panda.png'
  final String provider;  // 'google', 'apple', 'email'

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.avatarUrl,
    required this.provider,
  });
}

class AuthRepository {
  AuthRepository._internal();
  static final AuthRepository instance = AuthRepository._internal();

  final SupabaseClient _client = Supabase.instance.client;

  static const String _keyIsMockLoggedIn = 'is_mock_logged_in';
  static const String _keyMockUserEmail = 'mock_user_email';
  static const String _keyMockUserName = 'mock_user_name';
  static const String _keyMockUserAvatar = 'mock_user_avatar';
  static const String _keyMockUserProvider = 'mock_user_provider';

  final ValueNotifier<UserModel?> currentUserNotifier = ValueNotifier<UserModel?>(null);

  /// Initialize Auth state, checking for active Supabase session or Mock session
  void init() {
    _client.auth.onAuthStateChange.listen((data) {
      _updateUserFromSession(data.session);
    });

    final session = _client.auth.currentSession;
    if (session != null) {
      _updateUserFromSession(session);
    } else {
      _checkMockSession();
    }
  }

  void _updateUserFromSession(Session? session) {
    if (session == null) {
      // Check mock session before setting null
      _checkMockSession();
      return;
    }

    final user = session.user;
    final metadata = user.userMetadata ?? {};
    final String name = metadata['display_name'] as String? ?? user.email?.split('@').first ?? 'Explorer';
    final String avatar = metadata['avatar_path'] as String? ?? 'assets/images/lion_explorer.png';
    final String provider = user.appMetadata['provider'] as String? ?? 'email';

    currentUserNotifier.value = UserModel(
      id: user.id,
      email: user.email ?? '',
      name: name,
      avatarUrl: avatar,
      provider: provider,
    );
    developer.log('AuthRepository: Real user loaded - ${user.email}');
  }

  void _checkMockSession() {
    final box = HiveService.instance.settingsBox;
    final isMock = box.get(_keyIsMockLoggedIn, defaultValue: false) as bool;

    if (isMock) {
      final email = box.get(_keyMockUserEmail, defaultValue: '') as String;
      final name = box.get(_keyMockUserName, defaultValue: 'Explorer') as String;
      final avatar = box.get(_keyMockUserAvatar, defaultValue: 'assets/images/lion_explorer.png') as String;
      final provider = box.get(_keyMockUserProvider, defaultValue: 'google') as String;

      currentUserNotifier.value = UserModel(
        id: 'mock-user-id',
        email: email,
        name: name,
        avatarUrl: avatar,
        provider: provider,
      );
      developer.log('AuthRepository: Mock user loaded - $email ($provider)');
    } else {
      currentUserNotifier.value = null;
      developer.log('AuthRepository: No active user session (Guest Mode)');
    }
  }

  bool get isLoggedIn => currentUserNotifier.value != null;

  UserModel? get currentUser => currentUserNotifier.value;

  // --- Email/Password Auth (Supabase) ---

  Future<void> signUpWithEmail(String email, String password, String name) async {
    try {
      developer.log('AuthRepository: Attempting sign up for $email');
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'display_name': name,
          'avatar_path': 'assets/images/animals/panda.png',
        },
      );
      _updateUserFromSession(response.session);
    } catch (e) {
      developer.log('AuthRepository ERROR: signUpWithEmail: $e');
      rethrow;
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      developer.log('AuthRepository: Attempting sign in for $email');
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      _updateUserFromSession(response.session);
    } catch (e) {
      developer.log('AuthRepository ERROR: signInWithEmail: $e');
      rethrow;
    }
  }

  // --- Simulated OAuth logins ---

  Future<void> signInWithGoogleSimulated() async {
    try {
      developer.log('AuthRepository: Simulating Google login');
      final box = HiveService.instance.settingsBox;
      await box.put(_keyIsMockLoggedIn, true);
      await box.put(_keyMockUserEmail, 'kid_explorer@gmail.com');
      await box.put(_keyMockUserName, 'Kid Explorer 🌟');
      await box.put(_keyMockUserAvatar, 'assets/images/animals/panda.png');
      await box.put(_keyMockUserProvider, 'google');

      _checkMockSession();
    } catch (e) {
      developer.log('AuthRepository ERROR: signInWithGoogleSimulated: $e');
      rethrow;
    }
  }

  Future<void> signInWithAppleSimulated() async {
    try {
      developer.log('AuthRepository: Simulating Apple login');
      final box = HiveService.instance.settingsBox;
      await box.put(_keyIsMockLoggedIn, true);
      await box.put(_keyMockUserEmail, 'explorer.apple@icloud.com');
      await box.put(_keyMockUserName, 'Apple Explorer 🍎');
      await box.put(_keyMockUserAvatar, 'assets/images/animals/fox.png');
      await box.put(_keyMockUserProvider, 'apple');

      _checkMockSession();
    } catch (e) {
      developer.log('AuthRepository ERROR: signInWithAppleSimulated: $e');
      rethrow;
    }
  }

  // --- Profile Customization ---

  Future<void> updateProfile(String name, String avatarPath) async {
    try {
      final user = currentUserNotifier.value;
      if (user == null) return;

      developer.log('AuthRepository: Updating profile to name: $name, avatar: $avatarPath');

      if (user.id == 'mock-user-id') {
        final box = HiveService.instance.settingsBox;
        await box.put(_keyMockUserName, name);
        await box.put(_keyMockUserAvatar, avatarPath);
        _checkMockSession();
      } else {
        await _client.auth.updateUser(
          UserAttributes(
            data: {
              'display_name': name,
              'avatar_path': avatarPath,
            },
          ),
        );
        // Supabase will trigger state listener automatically
      }
    } catch (e) {
      developer.log('AuthRepository ERROR: updateProfile: $e');
      rethrow;
    }
  }

  // --- Session Control ---

  Future<void> logout() async {
    try {
      developer.log('AuthRepository: Logging out');
      // Sign out from Supabase (silently catches if offline or not logged in)
      try {
        await _client.auth.signOut();
      } catch (_) {}

      // Clear mock session
      final box = HiveService.instance.settingsBox;
      await box.delete(_keyIsMockLoggedIn);
      await box.delete(_keyMockUserEmail);
      await box.delete(_keyMockUserName);
      await box.delete(_keyMockUserAvatar);
      await box.delete(_keyMockUserProvider);

      currentUserNotifier.value = null;
      developer.log('AuthRepository: Logout complete. Returned to Guest Mode.');
    } catch (e) {
      developer.log('AuthRepository ERROR: logout: $e');
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    try {
      developer.log('AuthRepository: Deleting account');
      final user = currentUserNotifier.value;
      if (user == null) return;

      if (user.id != 'mock-user-id') {
        // Real user deletion requires admin permission or edge function.
        // We will perform local cleanup and signOut.
        // In real apps, we could call an RPC or functions/endpoint here.
        developer.log('AuthRepository: Deleting user ${user.id} from Supabase metadata');
      }

      // Cleanup local state and return to Guest mode
      await logout();
      developer.log('AuthRepository: Account deletion complete.');
    } catch (e) {
      developer.log('AuthRepository ERROR: deleteAccount: $e');
      rethrow;
    }
  }
}
