import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool readOnly;
  final VoidCallback? onTap;

  CustomTextField({
    required this.controller,
    required this.label,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      readOnly: readOnly,
      onTap: onTap,
    );
  }
}
