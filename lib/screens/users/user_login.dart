import 'package:flutter/material.dart';
import 'student_dashboard.dart';
import 'teacher_dashboard.dart';

class UserLoginScreen extends StatefulWidget {
  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  String role = 'Student'; // default

  void login() {
    if (role == 'Student') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => StudentDashboard()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => TeacherDashboard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: role,
              items: ['Student', 'Teacher'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => role = val!),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: Text("Login as $role"))
          ],
        ),
      ),
    );
  }
}
