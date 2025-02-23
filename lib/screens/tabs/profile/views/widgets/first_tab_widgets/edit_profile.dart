import 'package:flutter/material.dart';
import '../../../../../../helpers/themes/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
    required this.initialName,
    required this.initialEmail,
    required this.initialPassword,
  });

  final String initialName, initialEmail, initialPassword;

  @override
  State<EditProfile> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfile> {
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName;
    _emailController.text = widget.initialEmail;
    _passwordController.text = widget.initialPassword;

  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
        title: const Center(
          child: Text(
            'Edit Profile',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: ColorApp.thirdColor),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: _formKey,
              child: ListView(
               children: [
                _buildTextField('Name', 'Enter your name', _nameController),
                _buildTextField('Email', 'Enter your email', _emailController,
                    isEmail: true),
                _buildTextField('Password', 'Enter new password', _passwordController,
                    isPassword: true),
                const SizedBox(height: 220),
                _buildActionButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, String placeholder, TextEditingController controller,
      {bool isPassword = false, bool isEmail = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? !_showPassword : false,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
              color: ColorApp.thirdColor,
              fontWeight: FontWeight.w600,
              fontSize: 20),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          suffixIcon: isPassword
              ? IconButton(
            onPressed: () => setState(() => _showPassword = !_showPassword),
            icon: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
            ),
          ) : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          if (isEmail && !value.contains('@')) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            child: const Text('CANCEL',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    letterSpacing: 2.2,
                    color: ColorApp.thirdColor)),
          ),

          const Spacer(),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print({
                  'name': _nameController.text,
                  'email': _emailController.text,
                  'password': _passwordController.text,
                }); // Add this print statement

                Navigator.pop(context, {
                  'name': _nameController.text,
                  'email': _emailController.text,
                  'password': _passwordController.text,
                });
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('SAVE',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    letterSpacing: 2.2,
                    color: ColorApp.thirdColor)),
          ),
        ],
      ),
    );
  }
}