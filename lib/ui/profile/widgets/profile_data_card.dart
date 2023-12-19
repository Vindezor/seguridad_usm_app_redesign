import 'package:flutter/material.dart';

class ProfileDataCard extends StatelessWidget {
  final String title;
  final String text;

  const ProfileDataCard({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFddeaf4),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: -1
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5,bottom: 5),
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF3874c0),
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5,bottom: 5),
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF3874c0),
                  fontSize: 16
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}