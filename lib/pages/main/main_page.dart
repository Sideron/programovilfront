import 'package:flutter/material.dart';
import 'package:programovilfront/pages/Filtro_Universidad/profesores.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Universidad App',
      home: const SearchScreen(),
    );
  }
}
