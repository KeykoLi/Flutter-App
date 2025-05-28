import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hint;
  final bool obscure;
  final TextEditingController controller;

  const CustomInput({required this.hint, required this.controller,
    super.key, this.obscure = false,});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(hintText: hint),
    );
  }
}
