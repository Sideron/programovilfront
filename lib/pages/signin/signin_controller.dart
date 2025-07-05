import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/routes/app_routes.dart';
import 'package:programovilfront/services/user_services.dart';

class SigninController extends GetxController {
  UserService _userService = UserService();
  TextEditingController textName = TextEditingController();
  TextEditingController textMail = TextEditingController();
  TextEditingController textPassword = TextEditingController();
  TextEditingController textSecondPassword = TextEditingController();

  RxBool showPassword = true.obs;
  RxString errorMessage = ''.obs;

  void switchViewPassword() {
    showPassword.value = !showPassword.value;
  }

  void logIn(BuildContext context) {
    Future<String> validatedSignIn = _userService.validateSignIn(textMail.text,
        textName.text, textPassword.text, textSecondPassword.text);
    validatedSignIn.then((value) {
      if (value != "") {
        _setErrorMessage(value);
        return;
      }
      Navigator.pushNamed(context, AppRoutes.login);
    });
  }

  void goLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.login);
  }

  void _setErrorMessage(String message) {
    errorMessage.value = message;
    Future.delayed(Duration(seconds: 5), () {
      errorMessage.value = '';
    });
  }
}
