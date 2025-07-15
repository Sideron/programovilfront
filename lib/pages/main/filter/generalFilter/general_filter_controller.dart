import 'package:flutter/material.dart';
import 'package:programovilfront/models/colleges.dart';
import 'package:programovilfront/models/teachers.dart';
import 'package:programovilfront/services/college_service.dart';
import 'package:programovilfront/services/teacher_service.dart';
import 'package:get/get.dart';

class GeneralFilterController extends GetxController {
  final TeacherService _teacherService = TeacherService();
  final CollegeService _collegeService = CollegeService();

  var selectedFilter = 0.obs; // 0 = Profesores, 1 = Cursos
  var searchText = ''.obs;
  final TextEditingController searchController = TextEditingController();

  var allTeachers = <Teacher>[].obs;
  var allColleges = <College>[].obs;

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void updateFilter(int filter) {
    selectedFilter.value = filter;
    searchController.clear();
    searchText.value = '';
  }

  void updateSearchText(String text) {
    searchText.value = text;
  }

  Future<void> loadData() async {
    isLoading.value = true;

    print("cargando universidades...");

    final teachers = await _teacherService.getAllTeachers();
    final colleges = await _collegeService.loadCollegessFromJsonAsMap();
    print("Universidades: " + colleges.toString());

    allTeachers.value = teachers;
    allColleges.value = colleges;

    isLoading.value = false;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
