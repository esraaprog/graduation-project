import 'package:flutter/material.dart';
import 'register.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: Icon(Icons.menu),
        // title: Text('Login Screen'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.deepOrange),
            ),
          ),
          //SizedBox(width: 20,),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'Login',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepOrange[400],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange[500],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.deepOrange[400],
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: Row(
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to registration screen
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.deepOrange[400],
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
