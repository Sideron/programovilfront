import 'package:flutter/material.dart';
import 'package:programovilfront/config/token_manager.dart';
import 'package:programovilfront/routes/app_routes.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final TokenManager _tokenManager = TokenManager();

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final hasValidToken = await _tokenManager.hasValidToken();
    if (!mounted) return;

    if (hasValidToken) {
      Navigator.pushNamed(context, AppRoutes.main);
    } else {
      Navigator.pushNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
