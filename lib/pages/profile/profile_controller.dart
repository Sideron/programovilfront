import 'package:get/get.dart';
import '../../models/colleges.dart';
import '../../models/review_display.dart';
import '../../services/college_service.dart';
import '../../services/review_service.dart';
import '../../services/teacher_service.dart';

class ProfileController extends GetxController {
  var name = ''.obs;
  var image = ''.obs;
  var labels = <String>[].obs;
  var reviews = <ReviewDisplay>[].obs;
  var colleges = <College>[].obs;
  var selectCollege = Rx<College?>(null);
  var teacherSelect = 3;
  final _teacherService = TeacherService();
  final _collegeService = CollegeService();
  final _reviewService = ReviewService();
  
  @override
  void onInit() {
    super.onInit();
    _loadTeacherProfile();
    _loadReviews();
  }

  void _loadTeacherProfile() async {
    final teacher = await _teacherService.getTeacherById(teacherSelect);
    name.value = teacher.name;
    image.value = teacher.imageUrl;

    final allColleges = await _collegeService.getAllColleges();
    final teacherCollegeIds = await _teacherService.getTeacherCollegeIds(teacher.teacherId);

    final filtered = allColleges
        .where((c) => teacherCollegeIds.contains(c.collegeId))
        .toList();

    colleges.assignAll(filtered);
    if (colleges.isNotEmpty) {
      selectCollege.value = colleges.first;
    }
  }

  void _loadReviews() async {
    final result = await _reviewService.getReviewsForTeacher(teacherSelect);
    reviews.assignAll(result.reviews);
    labels.assignAll(result.usedLabelNames);
  }
}