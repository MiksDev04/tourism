// lib/ui/admin/pages/messages_page.dart
import 'package:flutter/material.dart';
import '../../shared/layouts/admin_layout.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

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