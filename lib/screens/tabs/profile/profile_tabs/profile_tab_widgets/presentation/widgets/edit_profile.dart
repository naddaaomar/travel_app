import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/auth/presentation/widgets/forget_password.dart';
import '../../data/model/user_profile_model.dart';
import '../manager/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/profile_state.dart';
import 'password_dialog.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile initialProfile;

  const EditProfileScreen({
    super.key,
    required this.initialProfile,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late UserProfile _editedProfile;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  bool _isPasswordVerified = false;
  bool _isLoading = false;

  double _cancelButtonYOffset = 0.0;
  double _saveButtonYOffset = 0.0;
  bool _cancelHovered = false;
  bool _saveHovered = false;

  @override
  void initState() {
    super.initState();
    _editedProfile = widget.initialProfile;
    _nameController.text = _editedProfile.name;
    _emailController.text = _editedProfile.email;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onCancelTapDown(TapDownDetails details) => setState(() => _cancelButtonYOffset = 5.0);
  void _onCancelTapUp(TapUpDetails details) => setState(() => _cancelButtonYOffset = 0.0);
  void _onCancelTapCancel() => setState(() => _cancelButtonYOffset = 0.0);
  void _onSaveTapDown(TapDownDetails details) => setState(() => _saveButtonYOffset = 5.0);
  void _onSaveTapUp(TapUpDetails details) => setState(() => _saveButtonYOffset = 0.0);
  void _onSaveTapCancel() => setState(() => _saveButtonYOffset = 0.0);

 /* Future<void> _verifyCurrentPassword() async {
    if (_currentPasswordController.text.isEmpty) {
      _showSnackBar('Please enter current password');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final isValid = await context.read<ProfileCubit>()
          .verifyPassword(_currentPasswordController.text);

      if (mounted) {
        setState(() {
          _isPasswordVerified = isValid;
          _isLoading = false;
        });

        if (!isValid) {
          _showSnackBar('Current password is incorrect');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showSnackBar('Error verifying password');
      }
    }
  }

  Future<void> _updatePassword() async {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      _showSnackBar('Passwords do not match');
      return;
    }

    if (_newPasswordController.text.length < 6) {
      _showSnackBar('Password must be at least 6 characters');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await context.read<ProfileCubit>().updatePassword(
        _currentPasswordController.text,
        _newPasswordController.text,
      );

      if (mounted && success) {
        setState(() {
          _isPasswordVerified = false;
          _currentPasswordController.clear();
          _newPasswordController.clear();
          _confirmPasswordController.clear();
          _isLoading = false;
        });
        _showSnackBar('Password updated successfully');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showSnackBar('Failed to update password');
      }
    }
  }

  */

  Future<void> _editPassword() async {
    await showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: BlocProvider.of<ProfileCubit>(context),
        child: PasswordDialog(
          onUpdatePassword: (currentPassword, newPassword) async {
            await context.read<ProfileCubit>().updatePassword(
              currentPassword,
              newPassword,
            );
            if (mounted && context.read<ProfileCubit>().state is ProfileLoaded) {
              Navigator.pop(context);
            }
          },
          userEmail: _editedProfile.email,
        ),
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<ProfileCubit>();
    cubit.updateName(_nameController.text);
    cubit.updateEmail(_emailController.text);

    Navigator.pop(context, _editedProfile.copyWith(
      name: _nameController.text,
      email: _emailController.text,
    ));
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          _showSnackBar(state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: ColorApp.thirdColor,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  buildTextField('Name', _nameController),
                  const SizedBox(height: 20),
                  buildTextField('Email', _emailController, isEmail: true),
                  const SizedBox(height: 20),
                  buildPasswordChangeSection(),
                  const SizedBox(height: 160),
                  buildActionButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String label,
      TextEditingController controller, {
        bool isEmail = false,
      }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: ColorApp.thirdColor,
          fontFamily: 'vol',
          fontWeight: FontWeight.w700,
        ),
        filled: true,
        fillColor: Colors.grey[100],
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
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (isEmail && !value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget buildPasswordChangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!_isPasswordVerified) ...[
          buildPasswordField(
            controller: _currentPasswordController,
            label: 'Current Password',
            showPassword: _showCurrentPassword,
            onToggleVisibility: () => setState(
                  () => _showCurrentPassword = !_showCurrentPassword,
            ),
          ),
          const SizedBox(height: 32),
          Column(
            children: [
              SizedBox(
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _editPassword,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                    'VERIFY PASSWORD',
                    style: TextStyle(
                      fontFamily: 'vol',
                      fontSize: 16,
                      color: ColorApp.thirdColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 7),
              SizedBox(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgetPassword(),
                      ),
                    );
                  },
                  child: const Text(
                    'FORGOT PASSWORD?',
                    style: TextStyle(
                      fontFamily: 'vol',
                      fontSize: 16,
                      color: ColorApp.thirdColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        if (_isPasswordVerified) ...[
          buildPasswordField(
            controller: _newPasswordController,
            label: 'New Password',
            showPassword: _showNewPassword,
            onToggleVisibility: () => setState(
                  () => _showNewPassword = !_showNewPassword,
            ),
          ),
          const SizedBox(height: 16),
          buildPasswordField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            showPassword: _showConfirmPassword,
            onToggleVisibility: () => setState(
                  () => _showConfirmPassword = !_showConfirmPassword,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _editPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),),
              child: const Text(
                'UPDATE PASSWORD',
                style: TextStyle(
                  fontFamily: 'vol',
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool showPassword,
    required VoidCallback onToggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: !showPassword,
      style: const TextStyle(color: Colors.black, fontFamily: 'vol'),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: ColorApp.thirdColor,
          fontFamily: 'vol',
          fontWeight: FontWeight.w700,
        ),
        filled: true,
        fillColor: Colors.grey[100],
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
          icon: Icon(
            showPassword ? Icons.visibility : Icons.visibility_off,
            color: ColorApp.thirdColor,
          ),
          onPressed: onToggleVisibility,
        ),
      ),
    );
  }

  Widget buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => _cancelHovered = true),
            onExit: (_) => setState(() => _cancelHovered = false),
            child: GestureDetector(
              onTapDown: _onCancelTapDown,
              onTapUp: _onCancelTapUp,
              onTapCancel: _onCancelTapCancel,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                transform: Matrix4.translationValues(
                    0, _cancelHovered ? -10.0 : _cancelButtonYOffset, 0),
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 25),),
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(
                      fontFamily: 'vol',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.2,
                      color: ColorApp.thirdColor,
                    ),
                  ),
                ),
              ),
            ),),
          const Spacer(),
          MouseRegion(
            onEnter: (_) => setState(() => _saveHovered = true),
            onExit: (_) => setState(() => _saveHovered = false),
            child: GestureDetector(
              onTapDown: _onSaveTapDown,
              onTapUp: _onSaveTapUp,
              onTapCancel: _onSaveTapCancel,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                transform: Matrix4.translationValues(
                    0, _saveHovered ? -10.0 : _saveButtonYOffset, 0),
                child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50),),
                    child: const Text(
                      'SAVE',
                      style: TextStyle(
                        fontFamily: 'vol',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: 2.2,
                        color: ColorApp.thirdColor,
                      ),)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}