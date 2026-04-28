import 'package:alarm/profile.dart';
import 'package:flutter/material.dart';

 Widget  criticalSituation(){
      
   return   ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.blue.shade100, child: Icon(Icons.person)),
              title: Text(' patient ${index + 1}'),
              subtitle: Text('Medication Status: Delayed ⚠️'),
              trailing: ElevatedButton(
                onPressed: () {
           
                  _showDecisionBottomSheet(context);
                },
                child: Text('Proceed'),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:  (context) => const PatientProfil()));
              },
            ),
          );
        },
      );
      
        
    
  }

void _showDecisionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Taking Decision Regarding Delayed Dose', style: TextStyle(fontWeight: FontWeight.bold)),
            Divider(),
            ListTile(
              leading: Icon(Icons.exposure_plus_2, color: Colors.orange),
              title: Text('Double the Next Dose'),
              onTap: () { /* Auto-adjustment code */ },
            ),
            ListTile(
              leading: Icon(Icons.cancel, color: Colors.red),
              title: Text('Register as Missed and Reschedule'),
              onTap: () { /* Rescheduling code */ },
            ),
          ],
        ),
      ),

    );
  }