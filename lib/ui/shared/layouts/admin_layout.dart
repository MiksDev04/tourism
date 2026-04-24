// lib/ui/shared/layouts/admin_layout.dart
import 'package:flutter/material.dart';
import '../widgets/admin_sidebar.dart';
import '../../../core/constants/app_colors.dart';

class AdminLayout extends StatefulWidget {
  final Widget child;
  final int selectedIndex;

  const AdminLayout({
    super.key,
    required this.child,
    required this.selectedIndex,
  });

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  void _onItemSelected(int index) {
    String route;
    switch (index) {
      case 0:
        route = '/admin/dashboard';
        break;
      case 1:
        route = '/admin/accommodations';
        break;
      case 2:
        route = '/admin/reports';
        break;
      case 3:
        route = '/admin/messages';
        break;
      case 4:
        route = '/admin/profile';
        break;
      default:
        route = '/admin/dashboard';
    }
    
    Navigator.pushReplacementNamed(context, route);
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AdminSidebar(
            selectedIndex: widget.selectedIndex,
            onItemSelected: _onItemSelected,
          ),
          Expanded(
            child: Container(
              color: AppColors.background,
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}