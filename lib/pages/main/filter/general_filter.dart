import 'package:flutter/material.dart';
import 'package:programovilfront/routes/app_routes.dart';
import 'package:programovilfront/services/college_service.dart';
import 'package:programovilfront/services/teacher_service.dart';

class GeneralFilter extends StatefulWidget {
  final void Function(int num) goPage;
  const GeneralFilter({super.key, required this.goPage});

  @override
  State<GeneralFilter> createState() => _GeneralFilterState();
}

class _GeneralFilterState extends State<GeneralFilter> {
  late void Function(int num) goPage;
  final TeacherService _teacherService = TeacherService();
  final CollegeService _collegeService = CollegeService();
  int selectedFilter = 0; // 0 = Profesores, 1 = Cursos
  final TextEditingController searchController = TextEditingController();
  String searchText = '';

  List<Map<String, dynamic>> allTeachers = [];

  List<Map<String, dynamic>> allColleges = [];

  Future<List<dynamic>>? allTeachers2;
  Future<List<dynamic>>? allColleges2;

  @override
  void initState() {
    super.initState();
    goPage = widget.goPage;
    allTeachers2 = _teacherService.getAllTeachers();
    allColleges2 = _collegeService.loadCollegessFromJsonAsMap();
    allColleges2!.then((value) {
      if (value.first is Map<String, dynamic>) {
        setState(() {
          allColleges = value.cast<Map<String, dynamic>>();
        });
        //print(jsonEncode(allColleges));
      }
    });

    allTeachers2!.then((value) {
      if (value.first is Map<String, dynamic>) {
        setState(() {
          allTeachers = value.cast<Map<String, dynamic>>();
        });
        //print(jsonEncode(allTeachers));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          buildHeader(),
          buildFilters(),
          Expanded(
            child: selectedFilter == 1
                ? buildTeachers()
                : buildColleges((int n) {
                    goPage(n);
                  }),
          ),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              "¡Tu opinion es importante!",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 21,
              ),
            ),
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
                          ? 'Buscar universidad'
                          : 'Buscar profesor',
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
          buildFilterButton("Universidades", 0),
          const SizedBox(width: 12),
          buildFilterButton("Profesores", 1),
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

  Widget buildColleges(void Function(int num) goPage) {
    final filteredColleges = allColleges
        .where((c) => c['name'].toLowerCase().contains(searchText))
        .toList();

    return ListView.builder(
      itemCount: filteredColleges.length,
      itemBuilder: (context, index) {
        final c = filteredColleges[index];
        return ListTile(
          onTap: () {
            goPage(c['college_id']);
          },
          leading: CircleAvatar(
            backgroundImage:
                c['image_url'] != null && c['image_url'].startsWith('http')
                    ? NetworkImage(c['image_url'])
                    : AssetImage('assets/images/profile.png') as ImageProvider,
            radius: 24,
          ),
          title: Text(c['name']),
          subtitle: Text(c['teachers_amount'].toString() + " profesores"),
        );
      },
    );
  }
}
