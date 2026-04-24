import 'package:flutter/material.dart';
import '../../shared/layouts/business_layout.dart';

class BusinessMessagesPage extends StatelessWidget {
  const BusinessMessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BusinessLayout(
      selectedIndex: 4,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Messages',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Coming Soon: View messages from Tourism Office'),
          ],
        ),
      ),
    );
  }
}