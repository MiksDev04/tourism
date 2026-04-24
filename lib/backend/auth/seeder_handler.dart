// lib/backend/auth/seeder_handler.dart
import '../../core/services/database_service.dart';
import '../../core/services/auth_service.dart';

class SeederHandler {
  final DatabaseService _db = DatabaseService.instance;
  
  Future<void> seedAdminAccount() async {
    try {
      print('Starting admin seeder...');
      
      // Check if any admin exists
      final checkQuery = 'SELECT COUNT(*) as total FROM users WHERE role = "admin"';
      final result = await _db.query(checkQuery);
      
      if (result.isNotEmpty && result.first['total'] != null) {
        final total = result.first['total'] as int;
        if (total > 0) {
          print('Admin account already exists');
          return;
        }
      }
      
      // Create admin account
      final hashedPassword = await AuthService.hashPassword('admin123');
      
      const insertQuery = '''
        INSERT INTO users (username, email, password_hash, full_name, role, status) 
        VALUES (?, ?, ?, ?, ?, ?)
      ''';
      
      await _db.execute(insertQuery, [
        'admin', 
        'admin@tourism.com', 
        hashedPassword, 
        'System Administrator', 
        'admin', 
        'active'
      ]);
      
      print('Admin account created successfully!');
      print('Email: admin@tourism.com');
      print('Password: admin123');
      
    } catch (e) {
      print('Error seeding admin: $e');
    }
  }
}