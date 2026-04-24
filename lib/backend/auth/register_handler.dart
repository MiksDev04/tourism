// lib/backend/auth/register_handler.dart
import '../../core/services/database_service.dart';
import '../../core/services/auth_service.dart';

class RegisterHandler {
  final DatabaseService _dbService = DatabaseService.instance;

  Future<Map<String, dynamic>> registerBusiness(Map<String, dynamic> businessData) async {
    try {
      final conn = await _dbService.connection;
      
      // Check if email already exists
      final existingUser = await conn.query(
        'SELECT email FROM users WHERE email = ?',
        [businessData['email']],
      );
      
      if (existingUser.isNotEmpty) {
        return {
          'success': false,
          'message': 'Email already registered'
        };
      }
      
      // Check if username already exists
      final existingUsername = await conn.query(
        'SELECT username FROM users WHERE username = ?',
        [businessData['username']],
      );
      
      if (existingUsername.isNotEmpty) {
        return {
          'success': false,
          'message': 'Username already taken'
        };
      }
      
      // Start transaction
      await conn.query('START TRANSACTION');
      
      try {
        // Hash password
        final passwordHash = await AuthService.hashPassword(businessData['password']);
        
        // Insert user
        final userResult = await conn.query(
          'INSERT INTO users (username, email, password_hash, full_name, role, status) '
          'VALUES (?, ?, ?, ?, ?, ?)',
          [
            businessData['username'],
            businessData['email'],
            passwordHash,
            businessData['full_name'],
            'business',
            'pending'
          ],
        );
        
        final userId = userResult.insertId;
        
        // Insert business
        await conn.query(
          'INSERT INTO businesses (user_id, business_name, business_type, owner_name, '
          'permit_number, registration_number, address, contact_number, email, total_rooms, '
          'permit_file_url, valid_id_url, status) '
          'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
          [
            userId,
            businessData['business_name'],
            businessData['business_type'],
            businessData['owner_name'],
            businessData['permit_number'],
            businessData['registration_number'],
            businessData['address'],
            businessData['contact_number'],
            businessData['business_email'],
            businessData['total_rooms'],
            businessData['permit_file_path'],
            businessData['valid_id_path'],
            'pending'
          ],
        );
        
        // Commit transaction
        await conn.query('COMMIT');
        
        return {
          'success': true,
          'message': 'Registration submitted successfully'
        };
      } catch (e) {
        await conn.query('ROLLBACK');
        return {
          'success': false,
          'message': 'Registration failed: $e'
        };
      }
    } catch (e) {
      print('Registration error: $e');
      return {
        'success': false,
        'message': 'Connection error: $e'
      };
    }
  }
}