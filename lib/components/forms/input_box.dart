import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final TextEditingController txtControl;
  final String hintText;
  final IconData icon;
  final bool obscure;
  final void Function()? suffixFunc;

  const InputBox(
      {super.key,
      required this.txtControl,
      required this.hintText,
      required this.icon,
      this.obscure = false,
      this.suffixFunc});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: txtControl,
      obscureText: obscure,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: suffixFunc ?? () {},
            icon: Icon(
              icon,
              size: 30,
              color: Color.fromARGB(255, 67, 191, 152),
            ),
          ),
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          hintText: hintText),
    );
  }
}
