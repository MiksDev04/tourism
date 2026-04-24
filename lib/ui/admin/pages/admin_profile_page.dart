// lib/ui/admin/pages/admin_profile_page.dart
import 'package:flutter/material.dart';
import '../../shared/layouts/admin_layout.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      selectedIndex: 4,
      child: const Center(
        child: Text('Profile Page - Coming Soon'),
      ),
    );
  }
}