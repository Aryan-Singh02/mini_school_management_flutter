import 'package:flutter/material.dart';

class StudentDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Dashboard")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome, Student!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("Class: 10A"),
            Text("Subjects: Math, Science, English"),
            SizedBox(height: 20),
            Text("Timetable:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Mon: Math, Science"),
            Text("Tue: English, Science"),
            Text("Wed: Math, English"),
            SizedBox(height: 20),
            Text("Notifications:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("• Midterm exams from 15th July"),
            Text("• Submit homework by Friday")
          ],
        ),
      ),
    );
  }
}
