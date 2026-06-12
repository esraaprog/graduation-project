import 'package:alarm/accountInformation.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Settings',
        style: TextStyle(
          color: Colors.white,
        ),
        ),
        elevation: 0.0,
      ),
  
      body: ListView(
        children: [

          // 🔹 معلومات الحساب
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Account Information"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountInformation()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Change Password"),
            onTap: () {},
          ),

          Divider(),

          // 🔹 إعدادات التطبيق
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Change Language"),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
            trailing: Switch(value: notificationsEnabled, onChanged: (val) {
              setState(() {
                notificationsEnabled = val;
              });
            }, 
            activeColor: Colors.deepOrange,
            ),
          ),

          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text("Dark Mode"),
            trailing: Switch(value: darkModeEnabled, onChanged: (val) {
              setState(() {
                darkModeEnabled = val;
              });
            }, activeColor: Colors.deepOrange,),
          ),

          Divider(),

          // 🔹 إعدادات طبية
          ListTile(
            leading: Icon(Icons.medical_services),
            title: Text("Specialization"),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.schedule),
            title: Text("Work Hours"),
            onTap: () {},
          ),

          Divider(),

          // 🔹 عام
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About the App"),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout"),
            onTap: () {},
          ),
        ],
      ),
    );
     
    
  }
}