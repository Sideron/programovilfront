import 'package:flutter/material.dart';
import 'package:programovilfront/pages/login/login_page.dart';
import 'package:programovilfront/pages/signin/signin_page.dart';

class AppRoutes {
  static const String login = '/loginpage';
  static const String signin = '/signinpage';

  static Widget mainPage = SigninPage();

  static Map<String, Widget Function(BuildContext)> routes(
      BuildContext context) {
    return {
      AppRoutes.login: (context) => LoginPage(),
      AppRoutes.signin: (context) => SigninPage(),
    };
  }
}
