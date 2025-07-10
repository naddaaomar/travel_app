import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/tabs/profile/auth/core/cubit/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/user_profile_model.dart';
import '../widgets/edit_profile.dart';
import '../manager/profile_cubit.dart';
import '../widgets/password_dialog.dart';
import '../widgets/profile_card.dart';

class ProfileScreen extends StatefulWidget {
  final String? token;
  final String name;
  final String email;
  final String password;

  const ProfileScreen({
    super.key,
    this.token,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile(
      widget.name,
      widget.email,
      widget.password,
    );
  }

  Future<void> _signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isSignedIn');
    await prefs.remove('email');
    await prefs.remove('name');
    await prefs.remove('password');

    if (!mounted) return;
    context.read<AuthCubit>().signOut();
    Navigator.pushNamedAndRemoveUntil(
      context, '/',
          (route) => false,
    );
  }

  Future<void> _navigateToEditProfile(UserProfile profile) async {
    final updatedProfile = await Navigator.push<UserProfile>(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<ProfileCubit>(context),
          child: EditProfileScreen(
            initialProfile: profile,
          ),
        ),
      ),
    );

    if (updatedProfile != null && mounted) {
      if (updatedProfile.name != profile.name) {
        context.read<ProfileCubit>().updateName(updatedProfile.name);
      }
      if (updatedProfile.email != profile.email) {
        context.read<ProfileCubit>().updateEmail(updatedProfile.email);
      }
    }
  }

  Future<void> _editPassword(UserProfile profile) async {
    await showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: BlocProvider.of<ProfileCubit>(context),
        child: PasswordDialog(
          onUpdatePassword: (currentPassword, newPassword) async {
            await context.read<ProfileCubit>().updatePassword(currentPassword, newPassword);
            if (mounted && context.read<ProfileCubit>().state is ProfileLoaded) {
              Navigator.pop(context);
            }
          },
          onResetPassword: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Password reset link sent to ${profile.email}'),
                duration: const Duration(seconds: 3),
              ),
            );
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileInitial || state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileLoaded || state is ProfilePasswordUpdated) {
            final profile = (state is ProfileLoaded)
                ? state.profile
                : (state as ProfilePasswordUpdated).profile;

            return SingleChildScrollView(
              padding: const EdgeInsets.only(
                  bottom: 20, left: 20, right: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ProfileCard(
                    profile: profile,
                    onEditName: () => _editField(
                      context,
                      'Username',
                      profile.name,
                          (newValue) => context.read<ProfileCubit>().updateName(newValue),
                    ),
                    onEditEmail: () => _editField(
                      context,
                      'Email',
                      profile.email,
                          (newValue) => context.read<ProfileCubit>().updateEmail(newValue),
                      isEmail: true,
                    ),
                    onEditPassword: () => _editPassword(profile),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        _buildEditButton(() => _navigateToEditProfile(profile)),
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
                              onPressed: _signOut,
                              tooltip: 'Sign Out',
                            ),
                            Text(
                              'Sign Out',
                              style: TextStyle(
                                fontFamily: 'vol',
                                color: ColorApp.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            );
          }

          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

  Widget _buildEditButton(VoidCallback onPressed) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: ColorApp.primaryColor),
          ),
          backgroundColor: Colors.white,
        ),
        onPressed: onPressed,
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

  Future<void> _editField(
      BuildContext context,
      String field,
      String currentValue,
      Function(String) onSave, {
        bool isEmail = false,
      }) async {
    final controller = TextEditingController(text: currentValue);
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $field'),
        content: isEmail
            ? TextFormField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: field,
            labelStyle: TextStyle(
              color: ColorApp.thirdColor,
              fontFamily: 'vol',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        )
            : TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: field,
            labelStyle: TextStyle(
              color: ColorApp.thirdColor,
              fontFamily: 'vol',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: ColorApp.thirdColor,
                fontFamily: 'vol',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (isEmail) {
                if (controller.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Email cannot be empty')),
                  );
                  return;
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(controller.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid email')),
                  );
                  return;
                }
              }
              Navigator.pop(context, true);
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: ColorApp.thirdColor,
                fontFamily: 'vol',
              ),
            ),
          ),
        ],
      ),
    );

    if (result == true && controller.text.trim().isNotEmpty && mounted) {
      onSave(controller.text.trim());
    }
  }
}