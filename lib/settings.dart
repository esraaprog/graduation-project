import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: IconButton(onPressed: (){}, icon:Icon(Icons.menu,color: Colors.white,),),
        title: Text('Settings',
        style: TextStyle(
          color: Colors.white,
        ),
        ),
        elevation: 0.0,
      ),
    
    );
  }
}