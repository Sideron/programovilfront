import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/routes/app_routes.dart';
import 'package:programovilfront/services/user_services.dart';

class LoginController extends GetxController {
  UserService _userService = UserService();
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
    Future<bool> canLog = _userService.login(textUser.text, textPassword.text);
    canLog.then((value) {
      if (value) {
        Navigator.pushNamed(context, AppRoutes.main);
      } else {
        _setErrorMessage('Usuario o contraseña incorrectos');
      }
    });
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
