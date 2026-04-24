// lib/routes/app_routes.dart
import 'package:flutter/material.dart';
import '../ui/admin/pages/login_page.dart';
import '../ui/admin/pages/dashboard_page.dart';
import '../ui/admin/pages/accommodations_page.dart';
import '../ui/admin/pages/reports_page.dart';
import '../ui/admin/pages/messages_page.dart';
import '../ui/admin/pages/profile_page.dart';
import '../ui/shared/pages/splash_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String adminLogin = '/admin/login';
  static const String adminDashboard = '/admin/dashboard';
  static const String adminAccommodations = '/admin/accommodations';
  static const String adminReports = '/admin/reports';
  static const String adminMessages = '/admin/messages';
  static const String adminProfile = '/admin/profile';
  
  static const String businessLogin = '/business/login';
  static const String businessRegister = '/business/register';
  static const String businessDashboard = '/business/dashboard';
  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashPage(), noAnimation: true);
      case adminLogin:
        return _buildRoute(const AdminLoginPage(), noAnimation: true);
      case adminDashboard:
        return _buildRoute(const AdminDashboardPage(), noAnimation: true);
      case adminAccommodations:
        return _buildRoute(const AccommodationsPage(), noAnimation: true);
      case adminReports:
        return _buildRoute(const ReportsPage(), noAnimation: true);
      case adminMessages:
        return _buildRoute(const MessagesPage(), noAnimation: true);
      case adminProfile:
        return _buildRoute(const AdminProfilePage(), noAnimation: true);
      default:
        return _buildRoute(const AdminLoginPage(), noAnimation: true);
    }
  }
  
  static Route<dynamic> _buildRoute(Widget page, {bool noAnimation = false}) {
    if (noAnimation) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }
    return MaterialPageRoute(builder: (context) => page);
  }
}