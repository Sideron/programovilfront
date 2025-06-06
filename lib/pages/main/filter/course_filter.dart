import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:programovilfront/models/courses.dart';
import 'package:programovilfront/routes/app_routes.dart';
import 'package:programovilfront/services/course_service.dart';
import 'package:programovilfront/services/teacher_service.dart';

class CourseFilter extends StatefulWidget {
  final void Function(int num) goPage;
  final int universityId;
  final int courseId;
  const CourseFilter(
      {super.key,
      required this.goPage,
      required this.universityId,
      required this.courseId});

  @override
  State<CourseFilter> createState() => _CourseFilterState();
}

class _CourseFilterState extends State<CourseFilter> {
  final CourseService _courseService = CourseService();
  final TeacherService _teacherService = TeacherService();
  List<Map<String, dynamic>> allTeachers = [];
  Future<List<dynamic>>? allTeachers2;
  Course? courseInfo;
  bool isLoading = true;

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
    Future<Course> courseTemp = _courseService.getCourseId(widget.courseId);
    courseTemp.then((value) {
      setState(() {
        courseInfo = value;
        isLoading = false;
      });
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
              child: Text(
                'Elige un profesor',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w300),
              )),
          Expanded(child: buildTeachers())
        ],
      ),
    ));
  }

  Widget buildHeader() {
    if (isLoading) {
      return Row(
        children: [
          TextButton.icon(
            onPressed: () {
              widget.goPage(0);
            },
            icon: Icon(Icons.arrow_back, size: 35),
            label: SizedBox(),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          ),
        ],
      );
    }
    return Row(
      children: [
        TextButton.icon(
          onPressed: () {
            widget.goPage(widget.universityId);
          },
          icon: Icon(Icons.arrow_back, size: 35),
          label: SizedBox(),
        ),
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
            child: Text(
              courseInfo!.name,
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
