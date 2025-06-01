import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/components/alerts/error_message_box.dart';
import 'package:programovilfront/components/forms/input_box.dart';
import 'package:programovilfront/components/forms/link_text.dart';
import 'package:programovilfront/components/forms/logo_app.dart';
import 'package:programovilfront/pages/login/login_controller.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginController control;

  @override
  void initState() {
    super.initState();
    control = Get.put(LoginController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 1, child: Container()),
          Expanded(
            flex: 20,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LogoApp(),
                  Text(
                    "Ingresa tu cuenta",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InputBox(
                            txtControl: control.textUser,
                            hintText: 'email@domain.com',
                            icon: Icons.mail_outline),
                        SizedBox(height: 15),
                        Obx(() => InputBox(
                              txtControl: control.textPassword,
                              hintText: 'Contraseña',
                              icon: Icons.remove_red_eye_outlined,
                              obscure: control.showPassword.value,
                              suffixFunc: () {
                                control.switchViewPassword();
                              },
                            )),
                        SizedBox(height: 7),
                        Obx(() => control.errorMessage.value == ''
                            ? Container()
                            : ErrorMessageBox(control.errorMessage.value)),
                        SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            control.logIn(context);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 67, 191, 152),
                              foregroundColor: Colors.white),
                          child: Text(
                            'Iniciar Sesión',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        LinkText(
                            firstText: 'No tienes una cuenta? ',
                            secondText: 'Regístrate aquí',
                            onClick: () {
                              control.goSignIn(context);
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
