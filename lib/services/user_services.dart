import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class UserService {
  Future<bool> login(String email, String password) async {
    final String response =
        await rootBundle.loadString('assets/json/users.json');
    final List<dynamic> users = json.decode(response);

    final matchingUsers = users
        .where((user) => user['email'] == email && user['password'] == password)
        .toList();

    return matchingUsers.isNotEmpty;
  }
}
