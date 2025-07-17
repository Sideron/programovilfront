import 'package:flutter/material.dart';
import 'package:programovilfront/pages/editProfile/edit_profile_page.dart';
import 'package:programovilfront/pages/login/login_page.dart';
import 'package:programovilfront/pages/main/main_page.dart';
import 'package:programovilfront/pages/rateTeacher/rateTeacher_page.dart';
import 'package:programovilfront/pages/signin/signin_page.dart';
import 'package:programovilfront/pages/profileTeacher/profileTeacher_page.dart';
import 'package:programovilfront/pages/profileUser/profileUser_page.dart';
import 'package:programovilfront/pages/splashscreen/splashscreen.dart';

class AppRoutes {
  static const String login = '/loginpage';
  static const String signin = '/signinpage';
  static const String main = '/mainpage';
  static const String profileTeacher = '/profileTeacher';
  static const String profileUser = '/profileUser';
  static const String rateTeacher = '/rateTeacher';

  static Widget mainPage = Splashscreen();

  static Map<String, Widget Function(BuildContext)> routes(
      BuildContext context) {
    return {
      AppRoutes.login: (context) => LoginPage(),
      AppRoutes.signin: (context) => SigninPage(),
      AppRoutes.main: (context) => MainPage(),
      AppRoutes.profileUser: (context) => ProfileUserPage(),
    };
  }

  static void goToProfileTeacher(BuildContext context, int idTeacher) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileTeacherPage(idTeacher: idTeacher),
      ),
    );
  }

  static Future<bool?> goToRateTeacherPage(
      BuildContext context, int idTeacher) {
    return Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => RateTeacherPage(idTeacher: idTeacher),
      ),
    );
  }

  static Future<bool?> goToEditProfilePage(
      BuildContext context, String nombre, String correo) {
    return Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfilePage(nombre: nombre, correo: correo),
      ),
    );
  }
}
