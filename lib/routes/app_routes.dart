// lib/routes/app_routes.dart (Updated with all business routes)
import 'package:flutter/material.dart';
import '../ui/shared/pages/login_page.dart';
import '../ui/shared/pages/splash_page.dart';
import '../ui/admin/pages/admin_dashboard_page.dart';
import '../ui/admin/pages/admin_accommodations_page.dart';
import '../ui/admin/pages/admin_reports_page.dart';
import '../ui/admin/pages/admin_messages_page.dart';
import '../ui/admin/pages/admin_profile_page.dart';
import '../ui/business/pages/business_register_page.dart';
import '../ui/business/pages/business_dashboard_page.dart';
import '../ui/business/pages/business_guest_entry_page.dart';
import '../ui/business/pages/business_guest_records_page.dart';
import '../ui/business/pages/business_reports_page.dart';
import '../ui/business/pages/business_messages_page.dart';
import '../ui/business/pages/business_profile_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String businessRegister = '/business/register';
  
  // Admin Routes
  static const String adminDashboard = '/admin/dashboard';
  static const String adminAccommodations = '/admin/accommodations';
  static const String adminReports = '/admin/reports';
  static const String adminMessages = '/admin/messages';
  static const String adminProfile = '/admin/profile';
  
  // Business Routes
  static const String businessDashboard = '/business/dashboard';
  static const String businessGuestEntry = '/business/guest-entry';
  static const String businessGuestRecords = '/business/guest-records';
  static const String businessReports = '/business/reports';
  static const String businessMessages = '/business/messages';
  static const String businessProfile = '/business/profile';
  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashPage(), noAnimation: true);
      case login:
        return _buildRoute(const LoginPage(), noAnimation: true);
      case businessRegister:
        return _buildRoute(const BusinessRegisterPage(), noAnimation: true);
      case adminDashboard:
        return _buildRoute(const AdminDashboardPage(), noAnimation: true);
      case adminAccommodations:
        return _buildRoute(const AdminAccommodationsPage(), noAnimation: true);
      case adminReports:
        return _buildRoute(const AdminReportsPage(), noAnimation: true);
      case adminMessages:
        return _buildRoute(const AdminMessagesPage(), noAnimation: true);
      case adminProfile:
        return _buildRoute(const AdminProfilePage(), noAnimation: true);
      case businessDashboard:
        return _buildRoute(const BusinessDashboardPage(), noAnimation: true);
      case businessGuestEntry:
        return _buildRoute(const BusinessGuestEntryPage(), noAnimation: true);
      case businessGuestRecords:
        return _buildRoute(const BusinessGuestRecordsPage(), noAnimation: true);
      case businessReports:
        return _buildRoute(const BusinessReportsPage(), noAnimation: true);
      case businessMessages:
        return _buildRoute(const BusinessMessagesPage(), noAnimation: true);
      case businessProfile:
        return _buildRoute(const BusinessProfilePage(), noAnimation: true);
      default:
        return _buildRoute(const LoginPage(), noAnimation: true);
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