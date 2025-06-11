import 'package:flutter/material.dart';
import '../../models/teacher.dart';
import '../../utils/shared_prefs.dart';

class AddTeacherScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();

  void saveTeacher(BuildContext context) async {
    if (nameController.text.isEmpty || emailController.text.isEmpty || subjectController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All fields are required")));
      return;
    }

    Teacher teacher = Teacher(
      name: nameController.text,
      email: emailController.text,
      subject: subjectController.text,
    );

    // Get existing teacher list
    var list = await SharedPrefs.getList('teachers');
    list.add(teacher.toJson());
    await SharedPrefs.saveList('teachers', list);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Teacher Added Successfully")));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Teacher')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: subjectController, decoration: InputDecoration(labelText: "Subject")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => saveTeacher(context), child: Text("Save"))
          ],
        ),
      ),
    );
  }
}
