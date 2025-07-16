import 'package:flutter/material.dart';

class AlertMessageBox extends StatelessWidget {
  const AlertMessageBox(this.message, {super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 147, 205, 253),
          borderRadius: BorderRadius.circular(10)),
      //margin: EdgeInsets.only(top: 15),
      child: Text(
        message,
        style: TextStyle(
            color: const Color.fromARGB(255, 18, 56, 112), fontSize: 16),
      ),
    );
  }
}
