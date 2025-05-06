import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    "Ingresa tu cuenta",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        inputBox('email@domain.com', Icons.mail_outline),
                        SizedBox(
                          height: 15,
                        ),
                        inputBox('Contraseña', Icons.remove_red_eye_outlined),
                        SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Iniciar Sesión',
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

  TextField inputBox(String hintText, IconData icon) {
    return TextField(
      decoration: InputDecoration(
          suffixIcon: Icon(
            icon,
            size: 30,
            color: Color.fromARGB(255, 67, 191, 152),
          ),
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          hintText: hintText),
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
