import 'package:flutter/material.dart';

class ErrorMessageBox extends StatelessWidget {
  const ErrorMessageBox(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      //margin: EdgeInsets.only(top: 15),
      child: Text(
        message,
        style: TextStyle(
            color: const Color.fromARGB(255, 180, 4, 4), fontSize: 16),
      ),
      decoration: BoxDecoration(
          color: const Color.fromARGB(136, 253, 154, 154),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
