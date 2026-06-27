import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/app_strings.dart';
import '../repositories/auth_repository.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_image.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isSignUp = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (_isSignUp) {
        await AuthRepository.instance.signUpWithEmail(email, password, name.isEmpty ? 'Explorer' : name);
      } else {
        await AuthRepository.instance.signInWithEmail(email, password);
      }
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '').split(':').last.trim();
        _isLoading = false;
      });
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await AuthRepository.instance.signInWithGoogleSimulated();
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loginWithApple() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await AuthRepository.instance.signInWithAppleSimulated();
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

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
                : [const Color(0xFFE0F7FA), const Color(0xFFFFF9C4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Top back button
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black45 : Colors.white70,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_rounded, color: isDark ? Colors.white : const Color(0xFF7C5730), size: 28),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),

              Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Cute Animal Mascot Header
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFFFD93D), width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: const ClipOval(
                          child: CustomImage(
                            pathOrUrl: 'assets/images/lion_explorer.png',
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Title
                      CustomText(
                        _isSignUp ? tr(AppStrings.signUp) : tr(AppStrings.login),
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : const Color(0xFF9E2A2B),
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        _isSignUp ? 'Join the learning adventure!' : 'Welcome back, explorer!',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.grey : const Color(0xFF7C5730),
                      ),
                      const SizedBox(height: 24),

                      // Input Form
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: isDark ? Colors.grey.shade800 : const Color(0xFFFFD93D),
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            )
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Name field (Sign Up only)
                              if (_isSignUp) ...[
                                TextFormField(
                                  controller: _nameController,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : const Color(0xFF7C5730),
                                  ),
                                  decoration: _inputDecoration(tr(AppStrings.name), Icons.person_rounded, isDark),
                                  validator: (v) => v == null || v.trim().isEmpty ? 'Please enter your name' : null,
                                ),
                                const SizedBox(height: 16),
                              ],

                              // Email Field
                              TextFormField(
                                controller: _emailController,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : const Color(0xFF7C5730),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                decoration: _inputDecoration(tr(AppStrings.email), Icons.email_rounded, isDark),
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty) return 'Please enter email';
                                  if (!v.contains('@')) return 'Please enter a valid email';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Password Field
                              TextFormField(
                                controller: _passwordController,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : const Color(0xFF7C5730),
                                ),
                                obscureText: true,
                                decoration: _inputDecoration(tr(AppStrings.password), Icons.lock_rounded, isDark),
                                validator: (v) => v == null || v.length < 6 ? 'Password must be at least 6 characters' : null,
                              ),

                              if (_errorMessage != null) ...[
                                const SizedBox(height: 16),
                                CustomText(
                                  _errorMessage!,
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                ),
                              ],

                              const SizedBox(height: 24),

                              // Submit Button
                              CustomButton(
                                backgroundColor: const Color(0xFF2E7D32),
                                onPressed: _isLoading ? () {} : _submit,
                                child: _isLoading
                                    ? const Center(
                                        child: SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                                        ),
                                      )
                                    : Center(
                                        child: CustomText(
                                          _isSignUp ? tr(AppStrings.signUp) : tr(AppStrings.login),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Social Logins
                      CustomText(
                        tr(AppStrings.orContinueWith),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.grey : const Color(0xFF7C5730),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Google Login Button
                          GestureDetector(
                            onTap: _isLoading ? null : _loginWithGoogle,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: const Color(0xFFE0DCCF), width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFD7D3C5),
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.g_mobiledata_rounded, color: Colors.red, size: 28),
                                  const SizedBox(width: 8),
                                  CustomText(
                                    'Google',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.grey.shade800,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Apple Login Button
                          GestureDetector(
                            onTap: _isLoading ? null : _loginWithApple,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.shade800, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade900,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.apple_rounded, color: Colors.white, size: 24),
                                  SizedBox(width: 8),
                                  CustomText(
                                    'Apple',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Toggle Login/SignUp
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            _isSignUp ? tr(AppStrings.alreadyHaveAccount) : tr(AppStrings.dontHaveAccount),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.grey : const Color(0xFF7C5730),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isSignUp = !_isSignUp;
                                _errorMessage = null;
                              });
                            },
                            child: CustomText(
                              _isSignUp ? tr(AppStrings.login) : tr(AppStrings.signUp),
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF2E7D32),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon, bool isDark) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: isDark ? Colors.grey : const Color(0xFF7C5730),
        fontWeight: FontWeight.bold,
      ),
      prefixIcon: Icon(icon, color: const Color(0xFF2E7D32)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: isDark ? Colors.grey.shade700 : const Color(0xFFE0DCCF),
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xFF2E7D32),
          width: 3,
        ),
      ),
      fillColor: isDark ? Colors.black26 : Colors.white,
      filled: true,
    );
  }
}
