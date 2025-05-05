import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          centerLogo(),
          Text(
            "Ingresa tu cuenta",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                inputBox(),
                SizedBox(
                  height: 15,
                ),
                inputBox()
              ],
            ),
          )
        ],
      ),
    );
  }

  TextField inputBox() {
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(), hintText: 'email@domain.com'),
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
