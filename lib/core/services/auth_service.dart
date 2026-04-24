// lib/core/services/auth_service.dart
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bcrypt/bcrypt.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();
  static const _sessionKey = 'user_session';
  
  static Future<void> setSession(Map<String, dynamic> session) async {
    final jsonString = jsonEncode(session);
    await _storage.write(key: _sessionKey, value: jsonString);
  }
  
  static Future<Map<String, dynamic>?> getSession() async {
    final session = await _storage.read(key: _sessionKey);
    if (session == null) return null;
    return jsonDecode(session) as Map<String, dynamic>;
  }
  
  static Future<void> clearSession() async {
    await _storage.delete(key: _sessionKey);
  }
  

  static Future<bool> isLoggedIn() async {
    final session = await _storage.read(key: _sessionKey);
    return session != null;
  }
  
  static Future<int?> getCurrentUserId() async {
    final session = await getSession();
    return session?['userId'] as int?;
  }
  
  static Future<String?> getCurrentUserRole() async {
    final session = await getSession();
    return session?['role'];
  }
  
  static Future<String> hashPassword(String password) async {
    final salt = BCrypt.gensalt();
    final hashedPassword = BCrypt.hashpw(password, salt);
    return hashedPassword;
  }
  
  static Future<bool> verifyPassword(String plainPassword, String hashedPassword) async {
    try {
      return BCrypt.checkpw(plainPassword, hashedPassword);
    } catch (e) {
      return false;
    }
  }
}