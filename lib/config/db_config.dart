class DatabaseConfig {
  static const String host = 'localhost';
  static const int port = 3306;
  static const String databaseName = 'tourism_db';
  static const String username = 'root';
  static const String password = '1234'; // Update with your MySQL password
  
  // Connection settings
  static const int maxConnections = 10;
  static const Duration connectionTimeout = Duration(seconds: 10);
}