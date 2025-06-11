import 'package:flutter/material.dart';
import '../../utils/shared_prefs.dart';
import 'edit_teacher.dart';

class TeacherListScreen extends StatefulWidget {
  @override
  _TeacherListScreenState createState() => _TeacherListScreenState();
}

class _TeacherListScreenState extends State<TeacherListScreen> {
  List<Map<String, dynamic>> teacherList = [];
  List<Map<String, dynamic>> filteredTeachers = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTeachers();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> loadTeachers() async {
    teacherList = await SharedPrefs.getList('teachers');
    filteredTeachers = teacherList;
    setState(() {});
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredTeachers = teacherList.where((teacher) {
        return teacher['name'].toLowerCase().contains(query) ||
               teacher['subject'].toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> deleteTeacher(int index) async {
    teacherList.removeAt(index);
    await SharedPrefs.saveList('teachers', teacherList);
    loadTeachers();
  }

  void editTeacher(int index) async {
    var updatedTeacher = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditTeacherScreen(
          teacherData: teacherList[index],
          index: index,
        ),
      ),
    );

    if (updatedTeacher != null) {
      teacherList[index] = updatedTeacher;
      await SharedPrefs.saveList('teachers', teacherList);
      loadTeachers();
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
      appBar: AppBar(title: Text("Teacher List")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by name or subject",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: filteredTeachers.isEmpty
                ? Center(child: Text("No teachers found."))
                : ListView.builder(
                    itemCount: filteredTeachers.length,
                    itemBuilder: (context, index) {
                      final teacher = filteredTeachers[index];
                      final actualIndex = teacherList.indexOf(teacher);
                      return Card(
                        child: ListTile(
                          title: Text(teacher['name']),
                          subtitle: Text("Subject: ${teacher['subject']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.orange),
                                onPressed: () => editTeacher(actualIndex),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteTeacher(actualIndex),
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
