import 'package:flutter/material.dart';
import 'package:programovilfront/pages/Filtro_Universidad/profesores.dart';
import 'package:programovilfront/pages/main/filter/filter_page.dart';
import 'package:programovilfront/pages/main/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPage = 0;

  late List pages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [FilterPage(), ProfilePage()];
  }

  void navigateBottomBar(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedPage],
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
