// lib/ui/admin/pages/admin_messages_page.dart
import 'package:flutter/material.dart';
import '../../shared/layouts/admin_layout.dart';

class AdminMessagesPage extends StatelessWidget {
  const AdminMessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      selectedIndex: 3,
      child: const Center(
        child: Text('Messages Page - Coming Soon'),
      ),
    );
  }
}