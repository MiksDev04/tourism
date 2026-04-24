// lib/ui/shared/layouts/business_layout.dart
import 'package:flutter/material.dart';
import '../widgets/business_sidebar.dart';
import '../../../core/constants/app_colors.dart';

class BusinessLayout extends StatefulWidget {
  final Widget child;
  final int selectedIndex;

  const BusinessLayout({
    super.key,
    required this.child,
    required this.selectedIndex,
  });

  @override
  State<BusinessLayout> createState() => _BusinessLayoutState();
}

class _BusinessLayoutState extends State<BusinessLayout> {
  void _onItemSelected(int index) {
    String route;
    switch (index) {
      case 0:
        route = '/business/dashboard';
        break;
      case 1:
        route = '/business/guest-entry';
        break;
      case 2:
        route = '/business/guest-records';
        break;
      case 3:
        route = '/business/reports';
        break;
      case 4:
        route = '/business/messages';
        break;
      case 5:
        route = '/business/profile';
        break;
      default:
        route = '/business/dashboard';
    }
    
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          BusinessSidebar(
            selectedIndex: widget.selectedIndex,
            onItemSelected: _onItemSelected,
            businessName: '', // Will be loaded from auth
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