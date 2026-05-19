import 'package:flutter/material.dart';

Widget DefultPasswordTextForm({
  required TextEditingController controller,
  required FormFieldValidator<String> validated,
  required VoidCallback onPressed,
  required Widget? suffixIcon,
  required bool isPasswordVisible,
}) => TextFormField(
  // Changed from TextField
  controller: controller,
  obscureText: !isPasswordVisible,

  // 1. Added validator for form handling
  validator: validated,

  decoration: InputDecoration(
    hintText: 'your password',
    prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFD2691E)),
    suffixIcon: IconButton(
      icon: Icon(
        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: const Color(0xFFD2691E),
      ),
      onPressed: onPressed,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFCD853F)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: const Color(0xFFCD853F).withOpacity(0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFD2691E), width: 2),
    ),
    // 2. Added error border styling (optional but recommended)
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ),
  ),
);
