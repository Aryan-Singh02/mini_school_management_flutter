import 'package:flutter/material.dart';
import 'admin_dashboard.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final adminEmail = 'admin@school.com';
  final adminPassword = 'admin123';

  void login() {
    if (emailController.text == adminEmail && passController.text == adminPassword) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => AdminDashboard()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Credentials")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passController, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
