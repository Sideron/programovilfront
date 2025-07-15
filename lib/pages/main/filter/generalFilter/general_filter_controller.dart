import 'package:flutter/material.dart';
import 'package:programovilfront/services/college_service.dart';
import 'package:programovilfront/services/teacher_service.dart';

class GeneralFilterController extends ChangeNotifier {
  final TeacherService _teacherService;
  final CollegeService _collegeService;

  int selectedFilter = 0;
  String searchText = '';
  final TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> allTeachers = [];
  List<Map<String, dynamic>> allColleges = [];

  bool isLoading = true;

  GeneralFilterController({
    required TeacherService teacherService,
    required CollegeService collegeService,
  })  : _teacherService = teacherService,
        _collegeService = collegeService;

  Future<void> loadData() async {
    isLoading = true;
    notifyListeners();

    final teachers = await _teacherService.getAllTeachers();
    final colleges = await _collegeService.loadCollegessFromJsonAsMap();

    allTeachers = teachers.cast<Map<String, dynamic>>();
    allColleges = colleges.cast<Map<String, dynamic>>();

    isLoading = false;
    notifyListeners();
  }

  void updateFilter(int newFilter) {
    selectedFilter = newFilter;
    notifyListeners();
  }

  void updateSearchText(String text) {
    searchText = text;
    notifyListeners();
  }

  void disposeController() {
    searchController.dispose();
  }
}
