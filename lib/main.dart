import 'package:flutter/material.dart';
import 'package:programovilfront/config/theme.dart';
import 'package:programovilfront/routes/app_routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: MaterialTheme.lightScheme(),
        useMaterial3: true,
      ),
      home: AppRoutes.mainPage,
      routes: AppRoutes.routes(context),
    );
  }
}
