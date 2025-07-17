import 'package:flutter/material.dart';
import 'package:programovilfront/pages/main/filter/filter_page.dart';
import 'package:programovilfront/pages/profileUser/profileUser_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPage = 0;
  Widget currentPage = FilterPage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void navigateBottomBar(int index) {
    setState(() {
      selectedPage = index;
      switch (selectedPage) {
        case 0:
          currentPage = FilterPage();
          break;
        case 1:
          currentPage = ProfileUserPage();
          break;
        default:
          currentPage = FilterPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
        backgroundColor: Color(0xff29ebae),
        selectedItemColor: Color(0xff1a1c1b),
        unselectedItemColor: Color.fromARGB(146, 26, 28, 27),
        iconSize: 30,
        currentIndex: selectedPage,
        showUnselectedLabels: false,
        onTap: navigateBottomBar,
      ),
    );
  }
}
