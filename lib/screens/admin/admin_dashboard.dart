import 'package:flutter/material.dart';
import '../../utils/shared_prefs.dart';
import 'add_student.dart';
import 'add_teacher.dart';
import 'student_list.dart';
import 'teacher_list.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int totalStudents = 0;
  int totalTeachers = 0;
  int totalClasses = 0;

  @override
  void initState() {
    super.initState();
    loadCounts();
  }

  Future<void> loadCounts() async {
    List studentList = await SharedPrefs.getList('students');
    List teacherList = await SharedPrefs.getList('teachers');

    // Get unique classes from student list
    Set<String> classSet = {};
    for (var student in studentList) {
      classSet.add(student['studentClass'] ?? '');
    }

    setState(() {
      totalStudents = studentList.length;
      totalTeachers = teacherList.length;
      totalClasses = classSet.length;
    });
  }

  Widget buildStatCard(String title, int value, Color color) {
    return Card(
      color: color,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
        trailing: Text(value.toString(),
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            buildStatCard("Total Students", totalStudents, Colors.blue),
            buildStatCard("Total Teachers", totalTeachers, Colors.green),
            buildStatCard("Total Classes", totalClasses, Colors.orange),
            SizedBox(height: 20),

            // Buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AddStudentScreen()))
                    .then((_) => loadCounts()); // Refresh on return
              },
              child: Text('Add Student'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AddTeacherScreen()))
                    .then((_) => loadCounts()); // Refresh on return
              },
              child: Text('Add Teacher'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => StudentListScreen()))
                    .then((_) => loadCounts());
              },
              child: Text("View Students"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => TeacherListScreen()))
                    .then((_) => loadCounts());
              },
              child: Text("View Teachers"),
            ),
          ],
        ),
      ),
    );
  }
}
