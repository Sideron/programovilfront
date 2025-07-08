import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  Future<bool> login(String email, String password) async {
    final String? baseUrl = dotenv.env['API_URL'];
    if (baseUrl == null) {
      throw Exception('BASE_URL no configurado en el .env');
    }

    final url = Uri.parse('$baseUrl/api/users/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Si necesitas session cookie:
          // 'Cookie': 'tu_session_aqui',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Puedes retornar true, guardar token o manejar como desees
        print('Login exitoso: ${response.body}');
        return true;
      } else {
        print('Error de login: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error al hacer login: $e');
      return false;
    }
  }

  Future<String> validateSignIn(
      String email, String name, String password, String secondPassword) async {
    final String? baseUrl = dotenv.env['API_URL'];
    if (baseUrl == null) {
      throw Exception('BASE_URL no configurado en el .env');
    }
    if (name.length < 5) {
      return 'El nombre debe tener más de 5 letras';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return 'Email invalido';
    }
    if (password.length < 8) {
      return 'Contraseña debe tener como mínimo 8 caracteres.';
    }
    if (password != secondPassword) {
      return 'Las contraseñas no coinciden';
    }
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/users/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "username": name,
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final data = jsonDecode(response.body);
        if (data['success'] == true || data['message'] == 'User created') {
          return "";
        } else {
          return data['message'] ?? 'Error desconocido al registrar';
        }
      } else {
        final data = jsonDecode(response.body);
        return data['message'] ??
            'Error en el registro: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error de conexión: $e';
    }
  }
}
