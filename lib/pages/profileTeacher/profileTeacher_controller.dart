import 'package:get/get.dart';
import 'package:programovilfront/models/labels.dart';
import '../../models/colleges.dart';
import '../../models/review_display.dart';
import '../../services/college_service.dart';
import '../../services/review_service.dart';
import '../../services/teacher_service.dart';

class ProfileTeacherController extends GetxController {
  var name = ''.obs;
  var image = ''.obs;
  var labels = <Label>[].obs;
  var reviews = <ReviewDisplay>[].obs;
  var colleges = <College>[].obs;
  var selectCollege = Rx<College?>(null);
  var showAllLabels = true.obs;

  late final int teacherSelect;

  final _teacherService = TeacherService();
  final _collegeService = CollegeService();
  final _reviewService = ReviewService();

  ProfileTeacherController(this.teacherSelect);

  @override
  void onInit() {
    super.onInit();
    _loadTeacherProfile();
    _loadReviews();
  }

  Future<void> _loadTeacherProfile() async {
    final teacher = await _teacherService.getTeacherById(teacherSelect);
    name.value = teacher.name;
    image.value = teacher.imageUrl;

    final allColleges = await _collegeService.getAllColleges();
    final teacherCollegeIds =
        await _teacherService.getTeacherCollegeIds(teacher.teacherId);

    final filtered = allColleges
        .where((c) => teacherCollegeIds.contains(c.collegeId))
        .toList();

    colleges.assignAll(filtered);
  }

  Future<void> _loadReviews() async {
    final result = await _reviewService.getReviewsForTeacher(teacherSelect);
    reviews.assignAll(result.reviews);

    final labelList = await _reviewService.getLabelsByTeacher(teacherSelect);
    labels.assignAll(labelList);
  }

  Future<void> reloadProfile() async {
    await _loadTeacherProfile();
    await _loadReviews();
  }
}
