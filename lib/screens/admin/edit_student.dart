import 'package:flutter/material.dart';

class EditStudentScreen extends StatefulWidget {
  final Map studentData;
  final int index;

  EditStudentScreen({required this.studentData, required this.index});

  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController classController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.studentData['name']);
    classController = TextEditingController(text: widget.studentData['studentClass']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Student")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Student Name"),
                validator: (value) => value!.isEmpty ? "Enter name" : null,
              ),
              TextFormField(
                controller: classController,
                decoration: InputDecoration(labelText: "Class"),
                validator: (value) => value!.isEmpty ? "Enter class" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Save Changes"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, {
                      'name': nameController.text,
                      'studentClass': classController.text,
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
