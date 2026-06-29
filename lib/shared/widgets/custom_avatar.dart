import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String initials;

  const CustomAvatar({super.key, required this.initials});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 45,

      child: Text(
        initials,

        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }
}
