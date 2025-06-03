import 'package:flutter/material.dart';
import 'package:programovilfront/pages/main/filter/general_filter.dart';
import 'package:programovilfront/pages/main/filter/university_filter.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  int currentPage = 0;
  late List pages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [GeneralFilter(), UniversityFilter()];
  }

  @override
  Widget build(BuildContext context) {
    return pages[currentPage];
  }
}
