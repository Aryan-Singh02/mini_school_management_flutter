import 'package:flutter/material.dart';

class EditTeacherScreen extends StatefulWidget {
  final Map<String, dynamic> teacherData;
  final int index;

  EditTeacherScreen({required this.teacherData, required this.index});

  @override
  _EditTeacherScreenState createState() => _EditTeacherScreenState();
}

class _EditTeacherScreenState extends State<EditTeacherScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController subjectController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.teacherData['name']);
    subjectController = TextEditingController(text: widget.teacherData['subject']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Teacher")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Teacher Name"),
                validator: (value) => value!.isEmpty ? "Enter name" : null,
              ),
              TextFormField(
                controller: subjectController,
                decoration: InputDecoration(labelText: "Subject"),
                validator: (value) => value!.isEmpty ? "Enter subject" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Save"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, {
                      'name': nameController.text,
                      'subject': subjectController.text,
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
