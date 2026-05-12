import 'package:alarm/criticalSituations.dart' show criticalSituation;
import 'package:alarm/files.dart';
import 'package:alarm/reports.dart';
import 'package:flutter/material.dart';

class Doctorhomescreen extends StatefulWidget {
  const Doctorhomescreen({super.key});

  @override
  State<Doctorhomescreen> createState() => _DoctorhomescreenState();
}

class _DoctorhomescreenState extends State<Doctorhomescreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
  length: 3, // عدد التبويبات التي تريدها
  child: Scaffold(
    appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: PopupMenuButton<String>(
       
  onSelected: (value) {
    if (value == 'Settings') {
      // انتقل إلى صفحة الإعدادات
    }
  },
  itemBuilder: (BuildContext context) {
    return [
      const PopupMenuItem<String>(
        value: 'Settings',
        child: Text('Settings'),
      ),
    ];
  },
         icon:Icon(Icons.menu,color: Colors.white,),),
        title: Text('My Profile',
        style: TextStyle(
          color: Colors.white,
        ),
        ),
        elevation: 0.0,
      bottom: TabBar( // نضع الـ TabBar غالباً في الجزء السفلي من الـ AppBar
        tabs: [
          Tab(icon: Icon(Icons.emergency), text: "Critical Situations"),
          Tab(icon: Icon(Icons.file_copy), text: "Patient Files"),
          Tab(icon: Icon(Icons.report), text: "Patient Reports"),
        ],
      ),
    ),
    body: TabBarView( // هنا نضع محتوى كل تبويب بنفس الترتيب
      children: [
        criticalSituation(),
        PatientFiles(),
        Reports(),
      ],
    ),
  ),
);
  }
}