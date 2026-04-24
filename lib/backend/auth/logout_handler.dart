// lib/backend/auth/logout_handler.dart
import '../../core/services/auth_service.dart';
import '../../core/services/database_service.dart';

class LogoutHandler {
  final DatabaseService _db = DatabaseService.instance;
  
  Future<void> logout(String userId) async {
    try {
      await _logActivity(userId, 'logout', 'User logged out');
      await AuthService.clearSession();
    } catch (e) {
      // Silent fail for logout
    }
  }
  
  Future<void> _logActivity(String userId, String action, String details) async {
    try {
      final logId = '${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
      await _db.execute('''
        INSERT INTO activity_logs (log_id, user_id, action, details)
        VALUES (?, ?, ?, ?)
      ''', [logId, userId, action, details]);
    } catch (e) {
      // Silent fail
    }
  }
}