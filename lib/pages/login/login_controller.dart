import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/routes/app_routes.dart';

class LoginController extends GetxController {
  TextEditingController textUser = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  RxBool showPassword = true.obs;
  RxString errorMessage = ''.obs;

  void switchViewPassword() {
    showPassword.value = !showPassword.value;
  }

  void logIn(BuildContext context) {
    print(textUser.text);
    print(textPassword.text);
    if (textUser.text == 'user' && textPassword.text == '123') {
      Navigator.pushNamed(context, AppRoutes.main);
    } else {
      _setErrorMessage('Usuario o contraseña incorrectos');
    }
  }

  void goSignIn(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signin);
  }

  void _setErrorMessage(String message) {
    errorMessage.value = message;
    Future.delayed(Duration(seconds: 5), () {
      errorMessage.value = '';
    });
  }
}
