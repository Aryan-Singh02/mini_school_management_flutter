import 'package:flutter/material.dart';
import 'screens/admin/admin_login.dart';
import 'screens/users/user_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("School Management")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminLoginScreen())), child: Text("Admin Login"))),
          Center(child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UserLoginScreen())), child: Text("User Login"))),
        ],
      ),
    );
  }
}
