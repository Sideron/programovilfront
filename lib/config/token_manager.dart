import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
    final token = await _storage.read(key: _jwtKey);
    if (token != null && !_isTokenExpired(token)) {
      return token;
    }

    // Token expirado o inválido → eliminarlo
    await deleteToken();
    return null;
  }

  /// Elimina el token (logout)
  Future<void> deleteToken() async {
    await _storage.delete(key: _jwtKey);
  }

  /// Verifica si hay un token guardado (útil para decidir si mostrar login o home)
  Future<bool> hasValidToken() async {
    final token = await _storage.read(key: _jwtKey);
    return token != null && !_isTokenExpired(token);
  }

  bool _isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }
}
