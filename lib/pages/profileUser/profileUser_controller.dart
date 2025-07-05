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
    final result = await reviewService.getReviewsByUser();
    final user = result.user;
    name.value = user.username;
    email.value = user.email;
    image.value = user.imageUrl;
    college.value = result.collegeName ?? 'Sin universidad';
    reviews.assignAll(result.reviews);
  }
}
