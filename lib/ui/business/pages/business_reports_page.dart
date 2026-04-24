// lib/ui/business/pages/business_reports_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../shared/layouts/business_layout.dart';

class BusinessReportsPage extends StatelessWidget {
  const BusinessReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BusinessLayout(
      selectedIndex: 3,
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reports',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Generate and export reports',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textMedium,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Center(
                child: Text(
                  'Reports Section - Coming Soon',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: AppColors.textLight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}