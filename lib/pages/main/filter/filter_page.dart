import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/pages/main/filter/general_filter.dart';
import 'package:programovilfront/pages/main/filter/university_filter.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  RxInt currentPage = 0.obs;
  late List pages;

  void goToPage(int pageIndex) {
    currentPage.value = pageIndex;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [
      GeneralFilter(
        goPage: goToPage,
      ),
      UniversityFilter()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return pages[currentPage.value];
  }
}
