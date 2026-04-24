// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/services/database_service.dart';
import 'backend/auth/seeder_handler.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database service on app start
  try {
    await DatabaseService.instance.testConnection();
    print('Database connection initialized successfully');
    
    // Run seeder to ensure admin exists
    final seeder = SeederHandler();
    await seeder.seedAdminAccount();
    
  } catch (e) {
    print('Warning: Database connection failed on startup: $e');
  }
  
  runApp(const MyApp());
}