import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/pages/main/filter/course_filter.dart';
import 'package:programovilfront/pages/main/filter/general_filter.dart';
import 'package:programovilfront/pages/main/filter/university_filter.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  RxInt currentPage = 2.obs;
  RxInt currentCollege = 1.obs;

  @override
  void initState() {
    super.initState();
  }

  void goToPage(int pageIndex) {
    currentPage.value = pageIndex;
  }

  void goCollegeFilter(int collegeId) {
    currentCollege.value = collegeId;
    currentPage.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final pages = [
        GeneralFilter(goPage: goCollegeFilter),
        UniversityFilter(
          universityId: currentCollege.value,
          goPage: goToPage,
        ),
        CourseFilter()
      ];
      return pages[currentPage.value];
    });
  }
}
