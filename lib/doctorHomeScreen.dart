import 'package:alarm/criticalSituations.dart' show criticalSituation;
import 'package:alarm/files.dart';
import 'package:alarm/reports.dart';
import 'package:alarm/settings.dart';
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
      animationDuration: Duration(milliseconds: 400),
      child: Scaffold(
        appBar: AppBar(
          
          backgroundColor: Colors.deepOrange,
          leading: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
           icon: Icon(Icons.more_vert_outlined, color: Colors.white),
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          ),

          title: Text('My Profile', style: TextStyle(color: Colors.white)),
          elevation: 0.0,
          bottom: TabBar(
           labelColor: Colors.white,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.white, width: 2.0),insets:  EdgeInsets.symmetric(horizontal: 10.0)),
              
              unselectedLabelColor: Colors.white70,
              labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: 12),
              isScrollable: false,
            // نضع الـ TabBar غالباً في الجزء السفلي من الـ AppBar
            tabs: [
              Tab(icon: Icon(Icons.emergency), text: "Critical Situations"),
              Tab(icon: Icon(Icons.file_copy), text: "Patient Files"),
              Tab(icon: Icon(Icons.report), text: "Patient Reports"),
            ],
          ),
        ),
        body: TabBarView(
          // هنا نضع محتوى كل تبويب بنفس الترتيب
          children: [criticalSituation(), PatientFiles(), Reports()],
        ),
      ),
    );
  }
}
