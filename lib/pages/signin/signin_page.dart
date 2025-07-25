import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programovilfront/components/alerts/error_message_box.dart';
import 'package:programovilfront/components/forms/input_box.dart';
import 'package:programovilfront/components/forms/link_text.dart';
import 'package:programovilfront/components/forms/logo_app.dart';
import 'package:programovilfront/pages/signin/signin_controller.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  late final SigninController control;

  @override
  void initState() {
    super.initState();
    control = Get.put(SigninController());
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
                    "Crea una cuenta",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  Text('Ingresa tu correo y contraseña'),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InputBox(
                            txtControl: control.textName,
                            hintText: 'Usuario',
                            icon: Icons.person),
                        SizedBox(height: 15),
                        InputBox(
                            txtControl: control.textMail,
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
                        SizedBox(height: 15),
                        InputBox(
                          txtControl: control.textSecondPassword,
                          hintText: 'Confirmar contraseña',
                          icon: Icons.repeat,
                          obscure: true,
                        ),
                        SizedBox(height: 7),
                        Obx(() => control.errorMessage.value == ''
                            ? Container()
                            : ErrorMessageBox(control.errorMessage.value)),
                        SizedBox(height: 7),
                        TextButton(
                          onPressed: () {
                            control.logIn(context);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 67, 191, 152),
                              foregroundColor: Colors.white),
                          child: Text(
                            'Registrate',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        LinkText(
                            firstText: 'Ya tienes una cuenta? ',
                            secondText: 'Ingresa aquí',
                            onClick: () {
                              control.goLogin(context);
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
