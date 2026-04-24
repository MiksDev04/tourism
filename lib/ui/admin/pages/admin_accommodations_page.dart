// lib/ui/admin/pages/admin_accommodations_page.dart
import 'package:flutter/material.dart';
import '../../shared/layouts/admin_layout.dart';

class AdminAccommodationsPage extends StatelessWidget {
  const AdminAccommodationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      selectedIndex: 1,
      child: const Center(
        child: Text('Accommodations Page - Coming Soon'),
      ),
    );
  }
}