import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../models/colleges.dart';
import '../../models/labels.dart';
import '../../models/review.dart';
import '../../models/review_display.dart';
import '../../models/teachers.dart';
import '../../models/teachers_colleges.dart';
import '../../models/user.dart';

class ProfileController extends GetxController {
  var name = ''.obs;
  var image = ''.obs;
  var labels = <String>[].obs;
  var reviews = <ReviewDisplay>[].obs;
  var colleges = <College>[].obs;
  var selectCollege = Rx<College?>(null);

  @override
  void onInit() {
    super.onInit();
    loadTeacherProfile();
    loadReviews();
  }
void loadTeacherProfile() async {
  // Cargar datos del profesor
  final teacherData = await rootBundle.loadString('assets/json/teachers.json');
  final List<dynamic> teacherJsonList = json.decode(teacherData);
  final teacherJson = teacherJsonList.firstWhere((t) => t['teacher_id'] == 1);
  final teacher = Teacher.fromJson(teacherJson);

  name.value = teacher.name;
  image.value = teacher.imageUrl;

  // Cargar todos los colleges
  final collegesData = await rootBundle.loadString('assets/json/colleges.json');
  final List<dynamic> collegesJsonList = json.decode(collegesData);
  final List<College> allColleges = collegesJsonList.map((json) => College.fromJson(json)).toList();

  // Cargar la relación teacher_colleges
  final teacherCollegesData = await rootBundle.loadString('assets/json/teachers_colleges.json');
  final List<dynamic> teacherCollegesJsonList = json.decode(teacherCollegesData);
  final List<TeacherCollege> teacherColleges = teacherCollegesJsonList
      .map((json) => TeacherCollege.fromJson(json))
      .where((tc) => tc.teacherId == teacher.teacherId)
      .toList();

  // Obtener los IDs de colleges asociados al profesor
  final Set<int> teacherCollegeIds = teacherColleges.map((tc) => tc.collegeId).toSet();

  // Filtrar colleges que estén relacionados con el profesor
  final List<College> filteredColleges = allColleges
      .where((college) => teacherCollegeIds.contains(college.collegeId))
      .toList();

  colleges.assignAll(filteredColleges);

  if (colleges.isNotEmpty) {
    selectCollege.value = colleges.first;
  }
}


  void loadReviews() async {
    final reviewsData = await rootBundle.loadString('assets/json/review.json');
    final reviewLabelsData = await rootBundle.loadString('assets/json/review_labels.json');
    final labelsData = await rootBundle.loadString('assets/json/labels.json');
    final usersData = await rootBundle.loadString('assets/json/users.json'); 

    final reviewsJson = json.decode(reviewsData) as List<dynamic>;
    final reviewLabelsJson = json.decode(reviewLabelsData) as List<dynamic>;
    final labelsJson = json.decode(labelsData) as List<dynamic>;
    final usersJson = json.decode(usersData) as List<dynamic>;

    final Map<int, Label> labelMap = {
      for (var label in labelsJson)
        label['label_id'] as int: Label.fromJson(label)
    };

    final Map<int, User> userMap = {
      for (var user in usersJson) user['user_id'] as int: User.fromJson(user)
    };

    final teacherReviews = reviewsJson.where((r) => r['teacher_id'] == 1);

    final List<ReviewDisplay> loadedReviews = [];
    final Set<String> usedLabelNames = {};

    for (var reviewJson in teacherReviews) {
      final reviewId = reviewJson['review_id'] as int;

      final labelIds = reviewLabelsJson
          .where((rl) => rl['review_id'] == reviewId)
          .map<int>((rl) => rl['label_id'] as int)
          .toList();

      final labels = labelIds.map((id) => labelMap[id]!).toList();

      final review = Review.fromJson(reviewJson);

      final int userId = reviewJson['user_id'] as int;
      final user = userMap[userId] ?? User( username: 'Anónimo', userId: 0, email: '', password: '', collegeId: 0, imageUrl: '');

      final display = ReviewDisplay.fromModels(
        review: review,
        user: user,
        emoji: reviewJson['emoji'] ?? '',
        labels: labels,
      );

      loadedReviews.add(display);
      usedLabelNames.addAll(labels.map((l) => l.name));
    }

    reviews.assignAll(loadedReviews);
    labels.assignAll(usedLabelNames.toList());
  }
}
