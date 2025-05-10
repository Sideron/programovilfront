import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController textUser = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  RxBool showPassword = true.obs;

  void switchViewPassword() {
    showPassword.value = !showPassword.value;
  }

  void logIn() {
    print(textUser.text);
    print(textPassword.text);
  }
}
