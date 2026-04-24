// lib/ui/business/pages/business_guest_entry_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../shared/layouts/business_layout.dart';

class BusinessGuestEntryPage extends StatelessWidget {
  const BusinessGuestEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BusinessLayout(
      selectedIndex: 1,
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Guest Entry',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Record tourist demographic data',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textMedium,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Center(
                child: Text(
                  'Guest Entry Form - Coming Soon',
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