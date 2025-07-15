import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/pages/main/filter/generalFilter/general_filter_controller.dart';
import 'package:programovilfront/routes/app_routes.dart';

class GeneralFilter extends StatelessWidget {
  final void Function(int num) goPage;
  final GeneralFilterController controller;

  const GeneralFilter({
    super.key,
    required this.goPage,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return Column(
          children: [
            buildHeader(),
            buildFilters(),
            controller.isLoading.value
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: controller.selectedFilter.value == 1
                        ? buildTeachers()
                        : buildColleges(goPage),
                  ),
          ],
        );
      }),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "¡Tu opinión es importante!",
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
                    controller: controller.searchController,
                    onChanged: (value) =>
                        controller.updateSearchText(value.toLowerCase()),
                    decoration: InputDecoration(
                      hintText: controller.selectedFilter.value == 0
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
      child: Obx(() => Row(
            children: [
              buildFilterButton("Universidades", 0),
              const SizedBox(width: 12),
              buildFilterButton("Profesores", 1),
            ],
          )),
    );
  }

  Widget buildFilterButton(String text, int index) {
    final isSelected = controller.selectedFilter.value == index;
    return GestureDetector(
      onTap: () => controller.updateFilter(index),
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
    final search = controller.searchText.value;
    final teachers = controller.allTeachers
        .where((t) => t.name.toLowerCase().contains(search))
        .toList();

    return ListView.builder(
      itemCount: teachers.length,
      itemBuilder: (context, index) {
        final t = teachers[index];
        return ListTile(
          onTap: () {
            AppRoutes.goToProfileTeacher(context, t.teacherId);
          },
          leading: CircleAvatar(
            backgroundImage:
                AssetImage(t.imageUrl ?? 'assets/images/profile.png'),
            radius: 24,
          ),
          title: Text(t.name),
          subtitle: Text("${t.ratings} calificaciones"),
        );
      },
    );
  }

  Widget buildColleges(void Function(int num) goPage) {
    final search = controller.searchText.value;
    final colleges = controller.allColleges
        .where((c) => c.name.toLowerCase().contains(search))
        .toList();

    return ListView.builder(
      itemCount: colleges.length,
      itemBuilder: (context, index) {
        final c = colleges[index];
        return ListTile(
          onTap: () => goPage(c.collegeId),
          leading: CircleAvatar(
            backgroundImage: c.imageUrl != null && c.imageUrl.startsWith('http')
                ? NetworkImage(c.imageUrl)
                : const AssetImage('assets/images/profile.png')
                    as ImageProvider,
            radius: 24,
          ),
          title: Text(c.name),
          subtitle: Text("${200} profesores"),
        );
      },
    );
  }
}
