import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int selectedFilter = 0; // 0 = Profesores, 1 = Cursos
  final TextEditingController searchController = TextEditingController();
  String searchText = '';

  final List<Map<String, dynamic>> allTeachers = [
    {'name': 'Ana Lopez', 'ratings': '300000 calificaciones', 'image': 'assets/images/profile.png', 'status': Colors.green},
    {'name': 'Luis Hernández', 'ratings': '280000 calificaciones', 'image': 'assets/images/profile.png', 'status': Colors.red},
    {'name': 'Susan Quiroz', 'ratings': '310000 calificaciones', 'image': 'assets/images/profile.png', 'status': Colors.green},
    {'name': 'Carlos Mejía', 'ratings': '290000 calificaciones', 'image': 'assets/images/profile.png', 'status': Colors.green},
    {'name': 'Universidad Nacional del Callao', 'ratings': '250000 calificaciones', 'image': 'assets/images/profile.png', 'status': Colors.red},
  ];

  final List<Map<String, dynamic>> allCourses = [
    {"name": "Programación Móvil", "profesores": "4 Profesores", "color": Colors.pink},
    {"name": "Interacción Humano Computadora", "profesores": "2 Profesores", "color": Colors.blue},
    {"name": "Simulación...", "profesores": "10 Profesores", "color": Colors.pinkAccent},
    {"name": "Programación Web", "profesores": "4 Profesores", "color": Colors.green},
    {"name": "Analítica de Big Data", "profesores": "4 Profesores", "color": Colors.orange},
    {"name": "Algoritmos", "profesores": "4 Profesores", "color": Colors.purple},
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
      bottomNavigationBar: buildBottomBar(),
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
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(t['image']),
                radius: 24,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  backgroundColor: t['status'],
                  radius: 6,
                ),
              ),
            ],
          ),
          title: Text(t['name']),
          subtitle: Text(t['ratings']),
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
          subtitle: Text(c['profesores']),
        );
      },
    );
  }

  Widget buildBottomBar() {
    return BottomAppBar(
      color: const Color(0xFF48C59E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          IconButton(icon: Icon(Icons.search, color: Colors.black), onPressed: null),
          IconButton(icon: Icon(Icons.person, color: Colors.black), onPressed: null),
        ],
      ),
    );
  }
}
