import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:programovilfront/routes/app_routes.dart';
import 'package:programovilfront/services/teacher_service.dart';

class CourseFilter extends StatefulWidget {
  const CourseFilter({super.key});

  @override
  State<CourseFilter> createState() => _CourseFilterState();
}

class _CourseFilterState extends State<CourseFilter> {
  final TeacherService _teacherService = TeacherService();
  List<Map<String, dynamic>> allTeachers = [];
  Future<List<dynamic>>? allTeachers2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allTeachers2 = _teacherService.getAllTeachers();
    allTeachers2!.then((value) {
      if (value.first is Map<String, dynamic>) {
        setState(() {
          allTeachers = value.cast<Map<String, dynamic>>();
        });
        print(jsonEncode(allTeachers));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Column(
        children: [
          buildHeader(),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Elige un profesor')),
          Expanded(child: buildTeachers())
        ],
      ),
    ));
  }

  Widget buildHeader() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 25,
          ),
        ),
        Expanded(
          flex: 6,
          child: Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Prog",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 21,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTeachers() {
    final filteredTeachers = allTeachers;

    return ListView.builder(
      itemCount: filteredTeachers.length,
      itemBuilder: (context, index) {
        final t = filteredTeachers[index];
        return ListTile(
          onTap: () {
            AppRoutes.goToProfileTeacher(context, t['teacher_id']);
          },
          leading: CircleAvatar(
            backgroundImage:
                AssetImage(t['image_url'] ?? 'assets/images/profile.png'),
            radius: 24,
          ),
          title: Text(t['name']),
          subtitle: Text(t['ratings'].toString() + " calificaciones"),
        );
      },
    );
  }
}
