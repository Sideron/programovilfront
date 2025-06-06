import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/models/group.dart';
import 'package:programovilfront/models/labels.dart';
import 'package:programovilfront/routes/app_routes.dart';
import 'package:programovilfront/services/label_service.dart';
import 'package:programovilfront/services/rate_service.dart';
import 'package:programovilfront/services/course_service.dart';

class RateTeacherController extends GetxController {
  final int idTeacher;
  RateTeacherController({required this.idTeacher});

  final RateService _rateService = RateService();
  final LabelService _labelService = LabelService();
  final CourseService _courseService = CourseService();
  RxList<Group> questions = <Group>[].obs;
  RxList<Label> allLabels = <Label>[].obs;
  RxList<Label> currentOptions = <Label>[].obs;
  RxList<String> courseOptions = <String>[].obs;
  RxString selectedCourse = ''.obs;
  TextEditingController commentController = TextEditingController();
  RxInt currentQuestionIndex = 0.obs;
  RxInt selectedIndex = (-1).obs;
  Group get currentQuestion => questions[currentQuestionIndex.value];

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    questions.value = await _rateService.loadGroupsFromJson();
    allLabels.value = await _labelService.loadLabelsFromJson();

    final courses = await _courseService.loadCoursesFromJson();
    courseOptions.value = courses.map((c) => c.name).toList();
    if (courseOptions.isNotEmpty) {
      selectedCourse.value = courseOptions.first;
    }

    updateCurrentOptions();
  }

  void updateCurrentOptions() {
    if (questions.isEmpty) {
      currentOptions.clear();
      return;
    }

    final groupId = currentQuestion.groupId;
    currentOptions.value =
        allLabels.where((label) => label.groupId == groupId).toList();

    selectedIndex.value = -1;
    commentController.clear();
  }

  void selectOption(int index) {
    selectedIndex.value = index;
  }

  void goToNextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex++;
      updateCurrentOptions();
    }
  }

  void reset() {
    currentQuestionIndex.value = 0;
    selectedIndex.value = -1;
    commentController.clear();
    if (courseOptions.isNotEmpty) {
      selectedCourse.value = courseOptions.first;
    }
    updateCurrentOptions();
  }

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }
}
