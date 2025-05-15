import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/tabs/profile/auth/core/cubit/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../helpers/themes/colors.dart';
import '../../../auth/presentation/sign_in.dart';
import 'profile_tab_widgets/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfile _profile;
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

 /* final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }
*/

  bool _isPasswordCorrect = false;
  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _profile = UserProfile(
      name: widget.name,
      email: widget.email,
      password: widget.password,
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signOut() async {
    setState(() => _isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInPage()),
    );
    setState(() => _isLoading = false);
  }

  Future<void> _navigateToEditProfile() async {
    final updatedProfile = await Navigator.push<UserProfile>(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfile(
          initialProfile: _profile,
        ),
      ),
    );

    if (updatedProfile != null && mounted) {
      setState(() => _profile = updatedProfile);
    }
  }

  Future<void> _verifyPassword() async {
    if (_currentPasswordController.text.isEmpty) {
      _showError('Please enter your current password');
      return;
    }

    if (_currentPasswordController.text != _profile.password) {
      _showError('Incorrect current password');
      return;
    }

    setState(() => _isPasswordCorrect = true);
  }

  Future<void> _sendResetEmail() async {
    setState(() => _isLoading = true);
    // email sending logic

    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Password reset link sent to ${_profile.email}'),
        duration: const Duration(seconds: 3),
      ),
    );
    setState(() => _isLoading = false);
    Navigator.pop(context);
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
    await Future.delayed(const Duration(seconds: 1)); // Simulate save operation

    if (!mounted) return;
    setState(() {
      _profile = _profile.copyWith(password: _newPasswordController.text);
      _isPasswordCorrect = false;
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    });

    Navigator.pop(context);
    _showSuccess('Password updated successfully');
    setState(() => _isLoading = false);
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

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _editPassword() async {
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
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
                      onToggleVisibility: () => setState(
                              () => _showCurrentPassword = !_showCurrentPassword),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _verifyPassword,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorApp.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('Verify Password',
                              style: TextStyle(
                                  fontFamily: "vol",
                                  color: Colors.black
                              ),),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextButton(
                            onPressed: _sendResetEmail,
                            child: const Text('Forgot Password?',
                            style: TextStyle(
                              fontFamily: "vol",
                              color: Colors.black
                            ),),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                  ],
                  if (_isPasswordCorrect) ...[
                    _buildPasswordField(
                      controller: _newPasswordController,
                      label: 'New Password',
                      showPassword: _showNewPassword,
                      onToggleVisibility: () => setState(
                              () => _showNewPassword = !_showNewPassword),
                    ),
                    const SizedBox(height: 16),
                    _buildPasswordField(
                      controller: _confirmPasswordController,
                      label: 'Confirm Password',
                      showPassword: _showConfirmPassword,
                      onToggleVisibility: () => setState(
                              () => _showConfirmPassword = !_showConfirmPassword),
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
                          : const Text('Update Password',
                        style: TextStyle(
                            fontFamily: "vol",
                            color: Colors.black
                        ),),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel',
                  style: TextStyle(
                      fontFamily: "vol",
                      color: Colors.black
                  ),),
              ),
            ],
          );
        },
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
        labelStyle: TextStyle(color: ColorApp.thirdColor,
          fontFamily: 'vol',),
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
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
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: Column(
           children: [
            const SizedBox(height: 20),
            _buildProfileCard(),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildEditButton(),
                  const Spacer(),
                  Column(
                    children: [
                      IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.logout,
                            color: Colors.red[700],
                            size: 24,
                          ),
                        ),
                        onPressed: () async {
                          final shouldLogout = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Sign Out'),
                              content: const Text('Are you sure you want to sign out?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('Cancel',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'vols'
                                    ),),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await context.read<AuthCubit>().signOut();
                                    Navigator.pushReplacement(
                                        context, MaterialPageRoute(builder:
                                        (context) => SignInPage()));
                                  },
                                  child: const Text('Sign Out',
                                      style: TextStyle(color: Colors.red,  fontFamily: 'vols')),
                                ),
                              ],
                            ),
                          );
                          if (shouldLogout == true) {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.clear();
                            if (mounted) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                               '/person_tab' ,
                                    (route) => false,
                              );
                            }
                          }
                        },
                        tooltip: 'Sign Out',
                      ),
                      Text('Sign Out',
                      style: TextStyle(
                        fontFamily: 'vol',
                        color: ColorApp.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileItem(
              title: 'Name',
              value: _profile.name,
              icon: Icons.person,
              onTap: () => _editField('Name', _profile.name, (newValue) {
                setState(() => _profile = _profile.copyWith(name: newValue));
              }),
            ),
            const Divider(height: 24),
            _buildProfileItem(
              title: 'Email',
              value: _profile.email,
              icon: Icons.email,
              onTap: () => _editField('Email', _profile.email, (newValue) {
                setState(() => _profile = _profile.copyWith(email: newValue));
              }),
            ),
            const Divider(height: 24),
            _buildProfileItem(
              title: 'Password',
              value: '••••••••',
              icon: Icons.lock,
              onTap: _editPassword,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required String title,
    required String value,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: ColorApp.primaryColor),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: onTap != null
          ? IconButton(
           icon: const Icon(Icons.edit, size: 20),
           onPressed: onTap,
      )
          : null,
      onTap: onTap,
    );
  }

  Widget _buildEditButton() {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: ColorApp.primaryColor),
          ),
          backgroundColor: Colors.white,
        ),
        onPressed: _navigateToEditProfile,
        child: Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: 'vol',
            color: ColorApp.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future<void> _editField(String field, String currentValue, Function(String) onSave) async {
    final controller = TextEditingController(text: currentValue);
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $field'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: field,
            labelStyle: TextStyle(color: ColorApp.thirdColor,
              fontFamily: 'vol',),
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
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel',
            style:  TextStyle(color: ColorApp.thirdColor,
              fontFamily: 'vol',),),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save',
            style:  TextStyle(color: ColorApp.thirdColor,
              fontFamily: 'vol',),),
          ),
        ],
      ),
    );

    if (result == true && controller.text.trim().isNotEmpty && mounted) {
      onSave(controller.text.trim());
    }
  }
}

class UserProfile {
  final String name;
  final String email;
  final String password;

  UserProfile({
    required this.name,
    required this.email,
    required this.password,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}