import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../models/colleges.dart';
import '../../models/review_display.dart';
import '../../models/user.dart';
import '../../services/college_service.dart';
import '../../services/review_service.dart';

class ProfileUserController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var college = ''.obs;
  var image = ''.obs;
  var reviews = <ReviewDisplay>[].obs;

  final reviewService = ReviewService();
  final collegeService = CollegeService();

  final int loggedUserId = 1;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    final usersJson = await rootBundle.loadString('assets/json/users.json');
    final usersData = json.decode(usersJson) as List<dynamic>;
    final userMap = {
      for (var u in usersData) u['user_id']: User.fromJson(u),
    };

    final user = userMap[loggedUserId];

    if (user != null) {
      name.value = user.username;
      email.value = user.email;
      image.value = user.imageUrl;

      final colleges = await collegeService.getAllColleges();
      final collegeName = colleges
              .firstWhere((c) => c.collegeId == user.collegeId,
                  orElse: () => College(collegeId: 0, name: '', imageUrl: ''))
              .name ??
          '';
      college.value = collegeName;

      final revs = await reviewService.getReviewsByUser(loggedUserId);
      reviews.assignAll(revs);
    }
  }
}
