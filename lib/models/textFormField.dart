import 'package:flutter/material.dart';

Widget textFormField(String label, TextEditingController controller) {
  return TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Specialization',
                        prefixIcon: Icon(Icons.medical_services),
                        border: OutlineInputBorder(),
                      ),
  );
}