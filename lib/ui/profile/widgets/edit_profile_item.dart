import 'package:flutter/material.dart';

class EditProfileItem extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final FocusNode focusNode;

  const EditProfileItem({
    super.key,
    required this.title,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        textInputAction: TextInputAction.done,
        obscureText: false,
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