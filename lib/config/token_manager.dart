import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static const _jwtKey = 'jwt_token';
  final FlutterSecureStorage _storage;

  // Constructor (puedes inyectarlo si deseas testearlo después)
  TokenManager() : _storage = const FlutterSecureStorage();

  /// Guarda el token JWT
  Future<void> saveToken(String token) async {
    await _storage.write(key: _jwtKey, value: token);
  }

  /// Obtiene el token guardado, o null si no existe
  Future<String?> getToken() async {
    return await _storage.read(key: _jwtKey);
  }

  /// Elimina el token (logout)
  Future<void> deleteToken() async {
    await _storage.delete(key: _jwtKey);
  }

  /// Verifica si hay un token guardado (útil para decidir si mostrar login o home)
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
