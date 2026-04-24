import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/header.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          BusinessSidebar(
            selectedIndex: widget.selectedIndex,
            onItemSelected: (index) {
              _navigateToPage(index);
            },
          ),
          
          // Main Content
          Expanded(
            child: Column(
              children: [
                const BusinessHeader(),
                Expanded(
                  child: Container(
                    color: Colors.grey[100],
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/business/dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/business/guest-entry');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/business/guest-records');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/business/reports');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/business/messages');
        break;
      case 5:
        Navigator.pushReplacementNamed(context, '/business/profile');
        break;
    }
  }
}