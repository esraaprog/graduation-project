import 'package:alarm/criticalSituations.dart';
import 'package:alarm/doctorHomeScreen.dart';
import 'package:alarm/files.dart';
import 'package:alarm/loginScreen.dart';
import 'package:alarm/reports.dart';
import 'package:alarm/settings.dart';
import 'package:alarm/wellcom.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());

}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home:Doctorhomescreen(),
    );
  }



}