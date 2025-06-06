import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:programovilfront/models/colleges.dart';
import 'package:programovilfront/routes/app_routes.dart';
import 'package:programovilfront/services/college_service.dart';
import 'package:programovilfront/services/course_service.dart';
import 'package:programovilfront/services/teacher_service.dart';

class UniversityFilter extends StatefulWidget {
  final int universityId;
  final void Function(int num) goPage;
  final void Function(int num) goCourse;
  const UniversityFilter(
      {Key? key,
      required this.universityId,
      required this.goPage,
      required this.goCourse})
      : super(key: key);

  @override
  State<UniversityFilter> createState() => _UniversityFilterState();
}

class _UniversityFilterState extends State<UniversityFilter> {
  late final int _universityId;
  College? _universityInfo;
  bool isLoading = true;
  final CollegeService _collegeService = CollegeService();
  final TeacherService _teacherService = TeacherService();
  final CourseService _courseService = CourseService();
  int selectedFilter = 0; // 0 = Profesores, 1 = Cursos
  final TextEditingController searchController = TextEditingController();
  String searchText = '';

  final random = Random();

  Color getRandomColor() {
    double hue = random.nextDouble() * 360; // Tonalidad entre 0 y 360
    double saturation = 1; // 0.7 - 1.0
    double brightness = 1; // 0.7 - 1.0

    return HSVColor.fromAHSV(1.0, hue, saturation, brightness).toColor();
  }

  List<Map<String, dynamic>> allTeachers = [];

  List<Map<String, dynamic>> allCourses = [];

  Future<List<dynamic>>? allTeachers2;
  Future<List<dynamic>>? allCourses2;

  @override
  void initState() {
    super.initState();
    _universityId = widget.universityId;
    Future<College>? infoCollegeTemp =
        _collegeService.getCollegeById(_universityId);
    infoCollegeTemp.then((value) {
      setState(() {
        _universityInfo = value;
        isLoading = false;
      });
      //print(jsonEncode(_universityInfo));
    });
    allTeachers2 = _teacherService.getTeachersInCollege(_universityId);
    _courseService.getCoursesByCollegeId(_universityId).then((courses) {
      setState(() {
        allCourses = courses.map((course) {
          return {
            'course_id': course.courseId,
            'name': course.name,
            'teachers_amount': course.teachersAmount,
            'color': getRandomColor()
          };
        }).toList();
      });
    });

    allTeachers2!.then((value) {
      if (value.first is Map<String, dynamic>) {
        setState(() {
          allTeachers = value.cast<Map<String, dynamic>>();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8FCF2),
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(),
            buildFilters(),
            Expanded(
              child: selectedFilter == 0 ? buildTeachers() : buildCourses(),
            ),
          ],
        ),
      ),
    );
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      widget.goPage(0);
                    },
                    icon: Icon(Icons.arrow_back, size: 35),
                    label: SizedBox(),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(_universityInfo!.imageUrl),
                    radius: 24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _universityInfo!.name,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF48C59E),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                const Icon(Icons.menu, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchText = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: selectedFilter == 0
                          ? 'Buscar profesor'
                          : 'Buscar curso',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Icon(Icons.search, color: Colors.white),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        children: [
          buildFilterButton("Profesores", 0),
          const SizedBox(width: 12),
          buildFilterButton("Cursos", 1),
        ],
      ),
    );
  }

  Widget buildFilterButton(String text, int index) {
    bool isSelected = selectedFilter == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = index;
          searchController.clear();
          searchText = '';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget buildTeachers() {
    if (allTeachers == null || allTeachers.isEmpty) {
      return const Center(child: Text('No hay profesores disponibles.'));
    }
    final filteredTeachers = allTeachers
        .where((t) => t['name'].toLowerCase().contains(searchText))
        .toList();

    print(filteredTeachers);

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

  Widget buildCourses() {
    final filteredCourses = allCourses
        .where((c) => c['name'].toLowerCase().contains(searchText))
        .toList();

    return ListView.builder(
      itemCount: filteredCourses.length,
      itemBuilder: (context, index) {
        final c = filteredCourses[index];
        return ListTile(
          onTap: () {
            widget.goCourse(c['course_id']);
          },
          leading: CircleAvatar(backgroundColor: c['color']),
          title: Text(c['name']),
          subtitle: Text(c['teachers_amount'].toString() + " profesores"),
        );
      },
    );
  }
}
