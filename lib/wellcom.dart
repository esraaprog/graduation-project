import 'package:flutter/material.dart';

class WellcomScreen extends StatefulWidget {
  const WellcomScreen({super.key});

  @override
  State<WellcomScreen> createState() => _WellcomScreenState();
}

class _WellcomScreenState extends State<WellcomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       Container(
        color: const Color.fromARGB(255, 237, 215, 222),
         child: Center(
          child: Text(
            'مرحباً بك في تطبيق المنبه',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 91, 19, 43),
            ),
          ),
               ),
       ),
    );
  }
}