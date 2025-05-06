import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:programovilfront/components/forms/input_box.dart';
import 'package:programovilfront/pages/signin/signin_controller.dart';

class SigninPage extends StatelessWidget {
  final SigninController control = Get.put(SigninController());

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
                  centerLogo(),
                  Text(
                    "Crea una cuenta",
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
                        SizedBox(
                          height: 15,
                        ),
                        Obx(() => InputBox(
                            txtControl: control.textPassword,
                            hintText: 'Contraseña',
                            icon: Icons.remove_red_eye_outlined,
                            obscure: control.showPassword.value,
                            suffixFunc: () {
                              control.switchViewPassword();
                            })),
                        SizedBox(
                          height: 15,
                        ),
                        InputBox(
                          txtControl: control.textSecondPassword,
                          hintText: 'Confirmar contraseña',
                          icon: Icons.repeat,
                          obscure: true,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () {
                            control.logIn();
                          },
                          child: Text(
                            'Registrate',
                            style: TextStyle(fontSize: 17),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 67, 191, 152),
                              foregroundColor: Colors.white),
                        )
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

  Row centerLogo() {
    return Row(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 6,
          child: SvgPicture.asset(
            'assets/images/logoLight.svg',
            height: 300,
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }
}
