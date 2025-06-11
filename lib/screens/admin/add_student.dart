import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../utils/shared_prefs.dart';

class AddStudentScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final classController = TextEditingController();

  void saveStudent(BuildContext context) async {
    Student student = Student(
      name: nameController.text,
      email: emailController.text,
      className: classController.text,
    );

    var list = await SharedPrefs.getList('students');
    list.add(student.toJson());
    await SharedPrefs.saveList('students', list);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student Added")));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Student')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: classController, decoration: InputDecoration(labelText: "Class")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => saveStudent(context), child: Text("Save"))
          ],
        ),
      ),
    );
  }
}
