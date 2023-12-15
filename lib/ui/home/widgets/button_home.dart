import 'package:flutter/material.dart';

class ButtonHome extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;
  const ButtonHome({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 30,
            color: Colors.black,
            spreadRadius: -10,
          )
        ]
      ),
      child: Material(
        borderRadius: BorderRadius.circular(40),
        color: const Color(0xFFddeaf4),
        child: InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: onTap,
          child: Ink(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(40),
              // boxShadow: const [
              //   BoxShadow(
              //     blurRadius: 30,
              //     color: Colors.black,
              //     spreadRadius: 2,
              //   )
              // ]
            ),
            height: 120.0,
            width: 120.0,
            child: FittedBox(
              child: Column(
                children: [
                  Icon(icon, color: const Color(0xFF3874c0)),
                  Text(text, style: const TextStyle(fontSize: 6, fontWeight: FontWeight.bold, color: Color(0xFF3874c0)),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}