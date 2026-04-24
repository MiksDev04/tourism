// lib/ui/admin/pages/reports_page.dart
import 'package:flutter/material.dart';
import '../../shared/layouts/admin_layout.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      selectedIndex: 2,
      child: const Center(
        child: Text('Reports Page - Coming Soon'),
      ),
    );
  }
}