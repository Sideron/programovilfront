import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/routes/app_routes.dart';

class LoginController extends GetxController {
  TextEditingController textUser = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  RxBool showPassword = true.obs;

  void switchViewPassword() {
    showPassword.value = !showPassword.value;
  }

  void logIn(BuildContext context) {
    print(textUser.text);
    print(textPassword.text);
    if (textUser.text == 'user' && textPassword.text == '123') {
      Navigator.pushNamed(context, AppRoutes.main);
    }
  }

  void goSignIn(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signin);
  }
}
