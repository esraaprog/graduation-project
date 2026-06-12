import 'package:alarm/profile.dart';
import 'package:flutter/material.dart';


  Widget PatientFiles() {
    return Scaffold(
      
        body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Icon(Icons.person),
              ),
              title: Text(' patient ${index + 1}'),
              subtitle: Text('Patient Health Record'),
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder:  (context) => const PatientProfil()));
              },
            ),
          );
        },
      ), 
    );
  }
