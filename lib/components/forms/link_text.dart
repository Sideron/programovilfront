import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  final String? firstText;
  final String? secondText;
  final void Function()? onClick;

  const LinkText({super.key, this.firstText, this.secondText, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 17),
          children: [
            TextSpan(
              text: firstText,
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
            TextSpan(
              text: secondText,
              style: TextStyle(
                  color: Color.fromARGB(255, 67, 191, 152),
                  fontWeight: FontWeight.w600),
              recognizer: TapGestureRecognizer()..onTap = onClick,
            ),
          ],
        ),
      ),
    );
  }
}
