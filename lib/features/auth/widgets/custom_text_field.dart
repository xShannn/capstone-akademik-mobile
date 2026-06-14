import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isObscure;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.isObscure = false, // Default-nya false (tidak disensor)
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: const Color(0xFFEBEBEB),
        // 1. Border bawaan
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Radius
          borderSide: BorderSide.none,
        ),

        // 2. Border saat form diam (tidak sedang diklik)
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Radius
          borderSide: BorderSide.none,
        ),

        // 3. Border saat form diklik (sedang mengetik)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Radius
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
      ),
    );
  }
}
