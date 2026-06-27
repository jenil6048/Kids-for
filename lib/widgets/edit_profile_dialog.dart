import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/app_strings.dart';
import '../repositories/auth_repository.dart';
import 'custom_text.dart';
import 'custom_button.dart';
import 'custom_image.dart';

class EditProfileDialog extends StatefulWidget {
  final UserModel currentUser;

  const EditProfileDialog({super.key, required this.currentUser});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late TextEditingController _nameController;
  late String _selectedAvatar;
  bool _isLoading = false;
  String? _errorMessage;

  final List<String> _avatars = const [
    'assets/images/lion_explorer.png',
    'assets/images/animals/panda.png',
    'assets/images/animals/fox.png',
    'assets/images/animals/bear.png',
    'assets/images/animals/elephant.png',
    'assets/images/animals/giraffe.png',
    'assets/images/animals/koala.png',
    'assets/images/animals/monkey.png',
    'assets/images/animals/rabbit.png',
    'assets/images/animals/zebra.png',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentUser.name);
    _selectedAvatar = widget.currentUser.avatarUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _errorMessage = 'Name cannot be empty';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await AuthRepository.instance.updateProfile(name, _selectedAvatar);
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to update profile. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dialog(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F3E8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
        side: BorderSide(
          color: const Color(0xFF2E7D32),
          width: 4,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                tr(AppStrings.editProfile),
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : const Color(0xFF9E2A2B),
              ),
              const SizedBox(height: 20),

              // Name Field
              TextField(
                controller: _nameController,
                maxLength: 15,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF7C5730),
                ),
                decoration: InputDecoration(
                  labelText: tr(AppStrings.name),
                  labelStyle: TextStyle(
                    color: isDark ? Colors.grey : const Color(0xFF7C5730),
                    fontWeight: FontWeight.bold,
                  ),
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
                  counterText: '',
                  fillColor: isDark ? Colors.black26 : Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),

              // Avatar Grid Title
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  'Choose your avatar:',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.grey : const Color(0xFF7C5730),
                ),
              ),
              const SizedBox(height: 10),

              // Avatar Selector Grid
              SizedBox(
                height: 180,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _avatars.length,
                  itemBuilder: (context, index) {
                    final avatar = _avatars[index];
                    final isSelected = _selectedAvatar == avatar;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAvatar = avatar;
                        });
                        HapticFeedback.lightImpact();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFFFD93D)
                              : (isDark ? Colors.black12 : Colors.white),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFFF9800)
                                : (isDark ? Colors.grey.shade700 : const Color(0xFFE0DCCF)),
                            width: isSelected ? 3 : 2,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFFFF9800).withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  )
                                ]
                              : null,
                        ),
                        child: ClipOval(
                          child: CustomImage(
                            pathOrUrl: avatar,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                CustomText(
                  _errorMessage!,
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ],

              const SizedBox(height: 24),

              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    backgroundColor: Colors.grey.shade400,
                    onPressed: _isLoading ? () {} : () => Navigator.of(context).pop(),
                    child: CustomText(
                      tr(AppStrings.cancel),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  CustomButton(
                    backgroundColor: const Color(0xFF2E7D32),
                    onPressed: _isLoading ? () {} : _save,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : CustomText(
                            tr(AppStrings.save),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
