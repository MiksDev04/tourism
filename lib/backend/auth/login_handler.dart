// lib/backend/auth/login_handler.dart
import 'dart:convert';
import '../../core/services/database_service.dart';
import '../../core/services/auth_service.dart';

class LoginHandler {
  final DatabaseService _db = DatabaseService.instance;
  
  Future<Map<String, dynamic>> authenticate(String email, String password) async {
    try {
      final query = '''
        SELECT user_id, username, email, password_hash, role, status, full_name
        FROM users 
        WHERE email = ? AND is_deleted = FALSE
      ''';
      
      final result = await _db.query(query, [email]);
      
      if (result.isEmpty) {
        return {'success': false, 'message': 'Invalid email or password'};
      }
      
      final user = result.first;
      
      if (user['status'] != 'active') {
        return {'success': false, 'message': 'Account is ${user['status']}. Please contact support.'};
      }
      
      final passwordValid = await AuthService.verifyPassword(password, user['password_hash']);
      
      if (!passwordValid) {
        return {'success': false, 'message': 'Invalid email or password'};
      }
      
      final session = {
        'userId': user['user_id'],
        'username': user['username'],
        'email': user['email'],
        'role': user['role'],
        'fullName': user['full_name'],
      };
      
      await AuthService.setSession(session);
      
      await _logActivity(user['user_id'].toString(), 'login', 'User logged in successfully');
      
      return {
        'success': true,
        'user': session,
        'role': user['role'],
      };
      
    } catch (e) {
      return {'success': false, 'message': 'Login failed: ${e.toString()}'};
    }
  }
  
  Future<void> _logActivity(String userId, String action, String details) async {
    await _db.execute('''
      INSERT INTO activity_logs (user_id, action, details)
      VALUES (?, ?, ?)
    ''', [int.parse(userId), action, details]);
  }
}