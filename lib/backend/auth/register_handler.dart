import 'package:mysql1/mysql1.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:uuid/uuid.dart';
import '../../core/services/database_service.dart';

class RegisterHandler {
  final DatabaseService _dbService = DatabaseService.instance;
  final Uuid _uuid = const Uuid();

  Future<bool> registerBusiness({
    required String businessName,
    required String email,
    required String password,
    required String ownerName,
    required String businessType,
    required String contactNumber,
    required String address,
    required int totalRooms,
  }) async {
    try {
      final conn = await _dbService.connection;
      
      // Check if email already exists
      final existingUser = await conn.query(
        'SELECT email FROM users WHERE email = ?',
        [email],
      );
      
      if (existingUser.isNotEmpty) {
        throw Exception('Email already registered');
      }
      
      // Start transaction
      await conn.query('START TRANSACTION');
      
      try {
        final userId = _uuid.v4();
        final businessId = _uuid.v4();
        final passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());
        
        // Insert user
        await conn.query(
          'INSERT INTO users (user_id, username, email, password_hash, full_name, role, status) '
          'VALUES (?, ?, ?, ?, ?, ?, ?)',
          [
            userId,
            businessName.replaceAll(' ', '_').toLowerCase(),
            email,
            passwordHash,
            ownerName,
            'business',
            'pending'
          ],
        );
        
        // Insert business
        await conn.query(
          'INSERT INTO businesses (business_id, user_id, business_name, business_type, owner_name, '
          'address, contact_number, email, total_rooms, status) '
          'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
          [
            businessId,
            userId,
            businessName,
            businessType,
            ownerName,
            address,
            contactNumber,
            email,
            totalRooms,
            'pending'
          ],
        );
        
        // Commit transaction
        await conn.query('COMMIT');
        
        return true;
      } catch (e) {
        await conn.query('ROLLBACK');
        rethrow;
      }
    } catch (e) {
      print('Registration error: $e');
      rethrow;
    }
  }
}