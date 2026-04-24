// lib/core/services/database_service.dart
import 'package:mysql1/mysql1.dart';
import '../../config/db_config.dart';

class DatabaseService {
  static DatabaseService? _instance;
  MySqlConnection? _connection;
  
  DatabaseService._internal();
  
  static DatabaseService get instance {
    _instance ??= DatabaseService._internal();
    return _instance!;
  }
  
  Future<MySqlConnection> get connection async {
    if (_connection == null || !await _isConnectionAlive()) {
      await connect();
    }
    return _connection!;
  }
  
  Future<bool> _isConnectionAlive() async {
    try {
      await _connection?.query('SELECT 1');
      return true;
    } catch (e) {
      return false;
    }
  }
  
  Future<void> connect() async {
    try {
      final settings = ConnectionSettings(
        host: DatabaseConfig.host,
        port: DatabaseConfig.port,
        user: DatabaseConfig.username,
        password: DatabaseConfig.password,
        db: DatabaseConfig.databaseName,
      );
      
      _connection = await MySqlConnection.connect(settings);
      print('Database connected successfully');
    } catch (e) {
      print('Database connection error: $e');
      rethrow;
    }
  }
  
  Future<void> disconnect() async {
    await _connection?.close();
    _connection = null;
  }
  
  Future<List<Map<String, dynamic>>> query(String sql, [List<dynamic>? params]) async {
    final conn = await connection;
    final results = await conn.query(sql, params);
    return results.map((row) => row.fields).toList();
  }
  
  Future<Results> execute(String sql, [List<dynamic>? params]) async {
    final conn = await connection;
    return await conn.query(sql, params);
  }
  
  Future<void> testConnection() async {
    try {
      final conn = await connection;
      final results = await conn.query('SELECT 1 as test');
      if (results.isNotEmpty) {
        print('Database test successful: ${results.first['test']}');
      }
    } catch (e) {
      print('Database test failed: $e');
      rethrow;
    }
  }
}