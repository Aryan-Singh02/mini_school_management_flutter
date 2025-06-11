// import 'package:flutter/material.dart';
// import '../../utils/shared_prefs.dart';

// class StudentListScreen extends StatefulWidget {
//   @override
//   _StudentListScreenState createState() => _StudentListScreenState();
// }

// class _StudentListScreenState extends State<StudentListScreen> {
//   List<Map<String, dynamic>> studentList = [];

//   @override
//   void initState() {
//     super.initState();
//     loadStudents();
//   }

//   void loadStudents() async {
//     List list = await SharedPrefs.getList('students');
//     setState(() {
//       studentList = List<Map<String, dynamic>>.from(list);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Students")),
//       body: ListView.builder(
//         itemCount: studentList.length,
//         itemBuilder: (context, index) {
//           var student = studentList[index];
//           return ListTile(
//             title: Text(student['name']),
//             subtitle: Text("Email: ${student['email']}, Class: ${student['studentClass']}"),
//           );
//         },
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import '../../utils/shared_prefs.dart';
// import 'edit_student.dart';

// class StudentListScreen extends StatefulWidget {
//   @override
//   _StudentListScreenState createState() => _StudentListScreenState();
// }

// class _StudentListScreenState extends State<StudentListScreen> {
//   List<Map<String, dynamic>> studentList = [];

//   @override
//   void initState() {
//     super.initState();
//     loadStudents();
//   }

//   Future<void> loadStudents() async {
//     studentList = await SharedPrefs.getList('students');
//     setState(() {});
//   }

//   Future<void> deleteStudent(int index) async {
//     studentList.removeAt(index);
//     await SharedPrefs.saveList('students', studentList);
//     loadStudents(); // refresh UI
//   }

//   void editStudent(int index) async {
//     var updatedStudent = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => EditStudentScreen(
//           studentData: studentList[index],
//           index: index,
//         ),
//       ),
//     );

//     if (updatedStudent != null) {
//       studentList[index] = updatedStudent;
//       await SharedPrefs.saveList('students', studentList);
//       loadStudents();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Student List")),
//       body: studentList.isEmpty
//           ? Center(child: Text("No students added yet."))
//           : ListView.builder(
//               itemCount: studentList.length,
//               itemBuilder: (context, index) {
//                 final student = studentList[index];
//                 return Card(
//                   child: ListTile(
//                     title: Text(student['name']),
//                     subtitle: Text("Class: ${student['studentClass']}"),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.edit, color: Colors.orange),
//                           onPressed: () => editStudent(index),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => deleteStudent(index),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../../utils/shared_prefs.dart';
import 'edit_student.dart';

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Map<String, dynamic>> studentList = [];
  List<Map<String, dynamic>> filteredStudents = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadStudents();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> loadStudents() async {
    studentList = await SharedPrefs.getList('students');
    filteredStudents = studentList;
    setState(() {});
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredStudents = studentList.where((student) {
        return student['name'].toLowerCase().contains(query) ||
               student['studentClass'].toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> deleteStudent(int index) async {
    studentList.removeAt(index);
    await SharedPrefs.saveList('students', studentList);
    loadStudents();
  }

  void editStudent(int index) async {
    var updatedStudent = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditStudentScreen(
          studentData: studentList[index],
          index: index,
        ),
      ),
    );

    if (updatedStudent != null) {
      studentList[index] = updatedStudent;
      await SharedPrefs.saveList('students', studentList);
      loadStudents();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student List")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by name or class",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: filteredStudents.isEmpty
                ? Center(child: Text("No students found."))
                : ListView.builder(
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      final student = filteredStudents[index];
                      final actualIndex = studentList.indexOf(student);
                      return Card(
                        child: ListTile(
                          title: Text(student['name']),
                          subtitle: Text("Class: ${student['studentClass']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.orange),
                                onPressed: () => editStudent(actualIndex),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteStudent(actualIndex),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
