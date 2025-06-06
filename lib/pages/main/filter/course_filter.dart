import 'package:flutter/material.dart';
import 'package:programovilfront/routes/app_routes.dart';

class CourseFilter extends StatefulWidget {
  const CourseFilter({super.key});

  @override
  State<CourseFilter> createState() => _CourseFilterState();
}

class _CourseFilterState extends State<CourseFilter> {
  List<Map<String, dynamic>> allTeachers = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Column(
        children: [
          buildHeader(),
          Align(
              alignment: Alignment.centerLeft, child: Text('Elige un profesor'))
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
    if (allTeachers.isEmpty) {
      return const Center(child: Text('No hay profesores disponibles.'));
    }

    return ListView.builder(
      itemCount: allTeachers.length,
      itemBuilder: (context, index) {
        final t = allTeachers[index];
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
