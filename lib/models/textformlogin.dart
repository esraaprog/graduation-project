import 'package:flutter/material.dart';

Widget defultTextFormLogin({
   required TextEditingController controller,
   required String hittext,
   required TextInputType keyboardType,
   required FormFieldValidator<String> validated,
   required IconData prifixIcon ,
   bool isPasswordVisible = false,
}) => TextFormField(
  controller: controller,
   validator: validated,
   obscureText: isPasswordVisible,
  decoration: InputDecoration(
    hintText: hittext,
    prefixIcon:  Icon(prifixIcon, color: Color(0xFFD2691E)),
    // suffixIcon: isPasswordVisible
    //     ? IconButton(
    //         icon: const Icon(
    //           Icons.visibility,
    //           color: Color(0xFFD2691E),
    //         ),
    //         onPressed: () {
    //           // Handle visibility toggle
    //         },
    //       )
    //     : IconButton(
    //         icon: const Icon(
    //           Icons.visibility_off,
    //           color: Color(0xFFD2691E),
    //         ),
    //         onPressed: () {
    //           // Handle visibility toggle
    //         },
    //       ),
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
   
  ),
  keyboardType: keyboardType,
);







