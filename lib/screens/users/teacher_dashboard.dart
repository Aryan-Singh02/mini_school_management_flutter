import 'package:flutter/material.dart';

class TeacherDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Teacher Dashboard")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome, Teacher!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("Subject: Science"),
            Text("Assigned Class: 10A"),
            SizedBox(height: 20),
            Text("Timetable:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Mon: 10A - Period 2"),
            Text("Tue: 10B - Period 4"),
            Text("Wed: 10A - Period 1"),
            SizedBox(height: 20),
            Text("Notifications:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("• Submit class report by Friday"),
            Text("• PTM scheduled on 20th July")
          ],
        ),
      ),
    );
  }
}
