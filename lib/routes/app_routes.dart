import 'package:flutter/material.dart';
import 'package:programovilfront/pages/login/login_page.dart';
import 'package:programovilfront/pages/main/main_page.dart';
import 'package:programovilfront/pages/profileTeacher/profileTeacher_page.dart';
import 'package:programovilfront/pages/profileUser/profileUser_page.dart';
import 'package:programovilfront/pages/signin/signin_page.dart';


class AppRoutes {
  static const String login = '/loginpage';
  static const String signin = '/signinpage';
  static const String profileTeacher = '/profileTeacher';
  static const String profileUser = '/profileUser';
  static const String main = '/mainpage';

  static Widget mainPage = ProfileTeacherPage();

  static Map<String, Widget Function(BuildContext)> routes(
      BuildContext context) {
    return {
      AppRoutes.login: (context) => LoginPage(),
      AppRoutes.signin: (context) => SigninPage(),
      AppRoutes.profileTeacher: (context) => ProfileTeacherPage(),
      //AppRoutes.profileUser: (context) => ProfileUserPage(),
      AppRoutes.main: (context) => MainPage()
    };
  }
}
