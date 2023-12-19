import 'package:flutter/material.dart';

class EditProfileItem extends StatelessWidget {
  final String title;

  const EditProfileItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextField(
        textInputAction: TextInputAction.next,
        obscureText: true,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          labelText: title,
        ),
      ),
    );
  }
}