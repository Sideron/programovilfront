import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/models/group.dart';
import 'package:programovilfront/models/labels.dart';
import 'package:programovilfront/models/courses.dart';
import 'package:programovilfront/services/label_service.dart';
import 'package:programovilfront/services/rate_service.dart';
import 'package:programovilfront/services/course_service.dart';

class RateTeacherController extends GetxController {
  final int idTeacher;
  RateTeacherController({required this.idTeacher});

  final _rateService = RateService();
  final _courseService = CourseService();

  final RxMap<Group, List<Label>> _groupLabelMap = <Group, List<Label>>{}.obs;
  final Map<int, int> selectedIndices = {};

  final courseList = <Course>[].obs;
  final questions = <Group>[].obs;
  final currentOptions = <Label>[].obs;

  final selectedCourse = RxnString();
  final courseOptions = <String>[].obs;
  final commentController = TextEditingController();

  final currentQuestionIndex = 0.obs;
  final selectedIndex = (-1).obs;

  Group get currentQuestion => questions[currentQuestionIndex.value];

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    final groupLabelMap = await _rateService.loadGroupsWithLabels();
    _groupLabelMap.value = groupLabelMap;
    questions.value = groupLabelMap.keys.toList();

    final courses = await _courseService.getCoursesByTeacher(idTeacher);
    courseList.value = courses;
    courseOptions.value = courses.map((c) => c.name).toList();

    if (courseOptions.isNotEmpty) {
      selectedCourse.value = courseOptions.first;
    } else {
      selectedCourse.value = null;
    }

    updateCurrentOptions();
  }

  void updateCurrentOptions() {
    final group = currentQuestion;
    currentOptions.value = _groupLabelMap[group] ?? [];
    selectedIndex.value = selectedIndices[group.groupId] ?? -1;
  }

  void selectOption(int index) {
    selectedIndex.value = index;
    selectedIndices[currentQuestion.groupId] = index;
  }

  void goToNextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      updateCurrentOptions();
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
      updateCurrentOptions();
    }
  }

  Future<void> enviarEvaluacion() async {
    final comment = commentController.text.trim();
    final courseName = selectedCourse.value;

    if (comment.isEmpty) {
      throw Exception('El comentario no puede estar vacío.');
    }

    if (courseName == null) {
      throw Exception('Debes seleccionar un curso.');
    }

    final course = courseList.firstWhere(
      (c) => c.name == courseName,
      orElse: () => throw Exception('Curso no encontrado.'),
    );

    final labelIds = <int>[];
    _groupLabelMap.forEach((group, labels) {
      final index = selectedIndices[group.groupId];
      if (index != null && index != -1) {
        labelIds.add(labels[index].labelId);
      }
    });

    if (labelIds.isEmpty) {
      throw Exception('Debes responder al menos una pregunta.');
    }

    await _rateService.submitReview(
      teacherId: idTeacher,
      courseId: course.courseId,
      comment: comment,
      labelIds: labelIds,
    );
  }

  void reset() {
    if (questions.isEmpty) return;
    currentQuestionIndex.value = 0;
    selectedIndex.value = -1;
    selectedIndices.clear();
    commentController.clear();
    if (courseOptions.isNotEmpty) {
      selectedCourse.value = courseOptions.first;
    } else {
      selectedCourse.value = null;
    }
    updateCurrentOptions();
  }

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }
}
