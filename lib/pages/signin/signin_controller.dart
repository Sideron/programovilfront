import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  TextEditingController textUser = TextEditingController();
  TextEditingController textPassword = TextEditingController();
  TextEditingController textSecondPassword = TextEditingController();

  RxBool showPassword = true.obs;

  void switchViewPassword() {
    showPassword.value = !showPassword.value;
    print("####################################");
    print(showPassword.value);
  }

  void logIn(BuildContext context) {
    print(textUser.text);
    print(textPassword.text);
    Navigator.pushNamed(context, '/loginpage');
  }
}
