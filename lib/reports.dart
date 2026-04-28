import 'package:flutter/material.dart';


  Widget Reports() {
    return Scaffold(
     
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Icon(Icons.person),
              ),
              title: Text('Patient Report ${index + 1}'),
              subtitle: Text('Weekly Patient Report'),
            
              onTap: () {
                //كود الاطلاع على التقاريرت
              },
            ),
          );
        },
      ),
    );
  }

