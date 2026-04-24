import 'package:flutter/material.dart';
import '../../shared/layouts/business_layout.dart';

class BusinessProfilePage extends StatelessWidget {
  const BusinessProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BusinessLayout(
      selectedIndex: 5,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.business_center, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Business Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Coming Soon: Manage your business information'),
          ],
        ),
      ),
    );
  }
}