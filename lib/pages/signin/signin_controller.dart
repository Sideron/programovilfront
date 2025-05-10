import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/routes/app_routes.dart';

class SigninController extends GetxController {
  TextEditingController textMail = TextEditingController();
  TextEditingController textPassword = TextEditingController();
  TextEditingController textSecondPassword = TextEditingController();

  RxBool showPassword = true.obs;
  RxString errorMessage = ''.obs;

  void switchViewPassword() {
    showPassword.value = !showPassword.value;
  }

  void logIn(BuildContext context) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(textMail.text)) {
      _setErrorMessage('Email invalido');
      return;
    }
    if (textPassword.text.length < 8) {
      _setErrorMessage('Contraseña debe tener como mínimo 8 caracteres.');
      return;
    }
    if (textPassword.text != textSecondPassword.text) {
      _setErrorMessage('Las contraseñas no coinciden');
      return;
    }
    Navigator.pushNamed(context, AppRoutes.main);
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
