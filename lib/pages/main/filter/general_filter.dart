import 'package:flutter/material.dart';

class GeneralFilter extends StatelessWidget {
  final void Function(int num) goPage;
  const GeneralFilter({super.key, required this.goPage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {
            goPage(1);
          },
          child: Text('Ir a universidad')),
    );
  }
}
