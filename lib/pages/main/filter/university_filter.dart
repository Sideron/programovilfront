import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:programovilfront/services/teacher_service.dart';

class UniversityFilter extends StatefulWidget {
  const UniversityFilter({Key? key}) : super(key: key);

  @override
  State<UniversityFilter> createState() => _UniversityFilterState();
}

class _UniversityFilterState extends State<UniversityFilter> {
  TeacherService teacherService = TeacherService();
  int selectedFilter = 0; // 0 = Profesores, 1 = Cursos
  final TextEditingController searchController = TextEditingController();
  String searchText = '';

  List<Map<String, dynamic>> allTeachers = [
    {
      'name': 'Ana Lopez',
      'ratings': 300000,
      'image': 'assets/images/profile.png',
    },
    {
      'name': 'Luis Hernández',
      'ratings': 280000,
      'image': 'assets/images/profile.png',
    },
    {
      'name': 'Susan Quiroz',
      'ratings': 310000,
      'image': 'assets/images/profile.png',
    },
    {
      'name': 'Carlos Mejía',
      'ratings': 290000,
      'image': 'assets/images/profile.png',
    },
    {
      'name': 'Universidad Nacional del Callao',
      'ratings': 250000,
      'image': 'assets/images/profile.png',
    },
  ];

  Future<List<dynamic>>? allTeachers2;

  @override
  void initState() {
    super.initState();
    allTeachers2 = teacherService.getTeachersInCollege(1);

    allTeachers2!.then((value) {
      if (value.first is Map<String, dynamic>) {
        setState(() {
          allTeachers = value.cast<Map<String, dynamic>>();
        });
        print(jsonEncode(allTeachers));
      }
    });
  }

  final List<Map<String, dynamic>> allCourses = [
    {"name": "Programación Móvil", "profesores": 4, "color": Colors.pink},
    {
      "name": "Interacción Humano Computadora",
      "profesores": 2,
      "color": Colors.blue
    },
    {"name": "Simulación...", "profesores": 10, "color": Colors.pinkAccent},
    {"name": "Programación Web", "profesores": 4, "color": Colors.green},
    {"name": "Analítica de Big Data", "profesores": 4, "color": Colors.orange},
    {"name": "Algoritmos", "profesores": 4, "color": Colors.purple},
  ];

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/images/logo.png', height: 40),
              const SizedBox(width: 8),
              const Text(
                "Universidad de Lima",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
    final filteredTeachers = allTeachers
        .where((t) => t['name'].toLowerCase().contains(searchText))
        .toList();

    return ListView.builder(
      itemCount: filteredTeachers.length,
      itemBuilder: (context, index) {
        final t = filteredTeachers[index];
        return ListTile(
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
          leading: CircleAvatar(backgroundColor: c['color']),
          title: Text(c['name']),
          subtitle: Text(c['profesores'].toString() + " profesores"),
        );
      },
    );
  }
}
