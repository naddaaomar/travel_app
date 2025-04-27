//NOT USED

import 'package:flutter/material.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({
    super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              NameWidget(title: 'Name', value: 'n', onPressed: (){},),
              EmailWidget(title: 'Email', value: 'n@gmail.com', onPressed: (){},),
              Divider(),
              PasswordWidget(title: 'Password', value: '********', onPressed: (){},),

            ],
          ),
        ),
      ),
    );
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onPressed,
    this.icon =Icons.arrow_forward_ios_rounded});

  final IconData icon ;
  final String title ,value ;
  final VoidCallback onPressed ;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:  Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,),
            ),
            Expanded(
              flex: 5,
              child: Text(value,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,),
            ),
            Expanded(
              child: Icon(icon, size: 18,),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onPressed,
    this.icon =Icons.arrow_forward_ios_rounded});

  final IconData icon ;
  final String title ,value ;
  final VoidCallback onPressed ;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:  Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,),
            ),
            Expanded(
              flex: 5,
              child: Text(value,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,),
            ),
            Expanded(
              child: Icon(icon, size: 18,),
            ),
          ],
        ),
      ),
    );
  }
}
class EmailWidget extends StatelessWidget {
  const EmailWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onPressed,
    this.icon =Icons.arrow_forward_ios_rounded});

  final IconData icon ;
  final String title ,value ;
  final VoidCallback onPressed ;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:  Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,),
            ),
            Expanded(
              flex: 5,
              child: Text(value,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,),
            ),
            Expanded(
              child: Icon(icon, size: 18,),
            ),
          ],
        ),
      ),
    );
  }
}