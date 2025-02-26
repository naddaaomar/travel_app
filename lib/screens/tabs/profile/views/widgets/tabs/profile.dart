import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../helpers/themes/colors.dart';
import '../../../pages/sign_in.dart';
import '../profile_tab_widgets/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.name,
    required this.value,
    required this.pass,
    this.icon = Icons.arrow_forward_ios_rounded,
  });

  final IconData icon;
  final String name, value, pass;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _name;
  late String _email;
  late String _password;

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _email = widget.value;
    _password = widget.pass;
  }

  Future<void> _signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
        child: Column(
          children: [
            const SizedBox(height: 40),
            _itemProfile('Name', _name, Icons.person, widget.icon, () => _editField('Name', _name, (newValue) => setState(() => _name = newValue))),
            const SizedBox(height: 10),
            _itemProfile('Email', _email, Icons.mail, widget.icon, () => _editField('Email', _email, (newValue) => setState(() => _email = newValue))),
            const SizedBox(height: 10),
            _itemProfile('Password', _password, Icons.password_sharp ,Icons.lock, (){} ),
            const SizedBox(height: 55),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(
                        initialName: _name,
                        initialEmail: _email,
                        initialPassword: _password,
                      ),
                    ),
                  ).then((updatedProfile) {
                    if (updatedProfile != null) {
                      setState(() {
                        _name = updatedProfile['name'] as String;
                        _email = updatedProfile['email'] as String;
                        _password = updatedProfile['password'] as String;
                      });
                      print('Updated profile: $updatedProfile');
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    color: ColorApp.primaryColor
                  ),
                  padding: const EdgeInsets.all(18),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: ColorApp.primaryColor,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemProfile(String title, String subtitle, IconData iconData, IconData trailingIcon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.deepOrange.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 15,
          )
        ],
      ),
      child: ListTile(
        title: Text(title,
          style: TextStyle(
          fontWeight: FontWeight.w500,
            color: ColorApp.thirdColor
        ),),
        subtitle: Text(subtitle,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 17
        ),),
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(iconData),
        ),
        trailing: IconButton(
          icon: Icon(trailingIcon),
          onPressed: onTap,
        ),
        tileColor: Colors.white,
      ),
    );
  }

  void _editField(String title, String currentValue, Function(String) onValueChanged) {
    TextEditingController controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $title',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: ColorApp.thirdColor
        ),),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: title),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
            style: TextStyle(
              color: ColorApp.thirdColor,
                fontWeight: FontWeight.w600
            ),),
          ),
          TextButton(
            onPressed: () {
              onValueChanged(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Save',
              style: TextStyle(
                  color: ColorApp.thirdColor,
                fontWeight: FontWeight.w600
              ),),
          ),
        ],
      ),
    );
  }
}