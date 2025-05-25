import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 6,
          child: SvgPicture.asset(
            Theme.of(context).brightness == Brightness.light
                ? 'assets/images/logoLight.svg'
                : 'assets/images/logoDark.svg',
            height: 300,
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }
}
