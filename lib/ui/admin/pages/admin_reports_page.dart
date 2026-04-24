// lib/ui/admin/pages/admin_reports_page.dart
import 'package:flutter/material.dart';
import '../../shared/layouts/admin_layout.dart';

class AdminReportsPage extends StatelessWidget {
  const AdminReportsPage({super.key});

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