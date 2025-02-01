import 'package:flutter/material.dart';

class PersonTab extends StatelessWidget {
  const PersonTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Icon(Icons.person)),
    );
  }
}