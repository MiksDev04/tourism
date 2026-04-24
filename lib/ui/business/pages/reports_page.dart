import 'package:flutter/material.dart';
import '../../shared/layouts/business_layout.dart';

class BusinessReportsPage extends StatelessWidget {
  const BusinessReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BusinessLayout(
      selectedIndex: 3,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assessment, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Business Reports',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Coming Soon: Generate and submit monthly reports'),
          ],
        ),
      ),
    );
  }
}