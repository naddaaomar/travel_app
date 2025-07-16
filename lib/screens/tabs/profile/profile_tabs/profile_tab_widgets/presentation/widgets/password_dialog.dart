import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/auth/presentation/widgets/forget_password.dart';

class PasswordDialog extends StatefulWidget {
  final Function(String, String) onUpdatePassword;
  final String userEmail;

  const PasswordDialog({
    super.key,
    required this.onUpdatePassword,
    required this.userEmail,
  });

  @override
  State<PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  bool _isPasswordCorrect = false;
  bool _isLoading = false;
  bool _showResetOption = false;

  void _verifyPassword() {
    if (_currentPasswordController.text.isEmpty) {
      _showError('Please enter your current password');
      return;
    }
    setState(() => _isPasswordCorrect = true);
  }

  Future<void> _updatePassword() async {
    if (_newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showError('Please fill all fields');
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      _showError('Passwords do not match');
      return;
    }

    if (_newPasswordController.text.length < 6) {
      _showError('Password must be at least 6 characters');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await widget.onUpdatePassword(
        _currentPasswordController.text,
        _newPasswordController.text,
      );

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      _showError('Failed to update password');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _navigateToResetPassword() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgetPassword(),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool showPassword,
    required VoidCallback onToggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: !showPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: ColorApp.thirdColor,
          fontFamily: 'vol',
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorApp.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorApp.primaryColor.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorApp.primaryColor, width: 2),
        ),
        suffixIcon: IconButton(
          icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
          color: ColorApp.thirdColor,
          onPressed: onToggleVisibility,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Password'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!_isPasswordCorrect) ...[
              _buildPasswordField(
                controller: _currentPasswordController,
                label: 'Current Password',
                showPassword: _showCurrentPassword,
                onToggleVisibility: () => setState(() => _showCurrentPassword = !_showCurrentPassword),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _verifyPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorApp.primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: const Text(
                        'Verify Password',
                        style: TextStyle(
                            fontFamily: "vol",
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() => _showResetOption = true);
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            fontFamily: "vol",
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (_showResetOption) ...[
                const SizedBox(height: 24),
                Text(
                  'Reset password link will be sent to:',
                  style: TextStyle(
                    fontFamily: 'vol',
                    color: Colors.black54,
                  ),
                ),
                Text(
                  widget.userEmail,
                  style: TextStyle(
                    fontFamily: 'vol',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _navigateToResetPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorApp.primaryColor,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text(
                    'Send Reset Link',
                    style: TextStyle(
                        fontFamily: "vol",
                        color: Colors.black
                    ),
                  ),
                ),
              ],
              const Divider(height: 24),
            ],
            if (_isPasswordCorrect) ...[
              _buildPasswordField(
                controller: _newPasswordController,
                label: 'New Password',
                showPassword: _showNewPassword,
                onToggleVisibility: () => setState(() => _showNewPassword = !_showNewPassword),
              ),
              const SizedBox(height: 16),
              _buildPasswordField(
                controller: _confirmPasswordController,
                label: 'Confirm Password',
                showPassword: _showConfirmPassword,
                onToggleVisibility: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _updatePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorApp.primaryColor,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  'Update Password',
                  style: TextStyle(
                      fontFamily: "vol",
                      color: Colors.black
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(
                fontFamily: "vol",
                color: Colors.black
            ),
          ),
        ),
      ],
    );
  }
}