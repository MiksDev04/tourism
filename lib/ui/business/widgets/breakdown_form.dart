// lib/ui/business/widgets/breakdown_form.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class BreakdownForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final VoidCallback onCancel;

  const BreakdownForm({
    super.key,
    required this.onSubmit,
    required this.onCancel,
  });

  @override
  State<BreakdownForm> createState() => _BreakdownFormState();
}

class _BreakdownFormState extends State<BreakdownForm> {
  final _formKey = GlobalKey<FormState>();
  
  String? _nationality;
  String? _philippinesRegion;
  String? _gender;
  String? _ageGroup;
  int _count = 1;
  bool _isPhilippines = false;
  
  final List<String> _nationalities = [
    'Philippines',
    'United States',
    'China',
    'Japan',
    'South Korea',
    'Australia',
    'United Kingdom',
    'Germany',
    'France',
    'Canada',
    'Other',
  ];
  
  final List<String> _philippinesRegions = [
    'NCR - National Capital Region',
    'CAR - Cordillera Administrative Region',
    'Region I - Ilocos Region',
    'Region II - Cagayan Valley',
    'Region III - Central Luzon',
    'Region IV-A - CALABARZON',
    'Region IV-B - MIMAROPA',
    'Region V - Bicol Region',
    'Region VI - Western Visayas',
    'Region VII - Central Visayas',
    'Region VIII - Eastern Visayas',
    'Region IX - Zamboanga Peninsula',
    'Region X - Northern Mindanao',
    'Region XI - Davao Region',
    'Region XII - SOCCSKSARGEN',
    'Region XIII - Caraga',
    'BARMM - Bangsamoro Autonomous Region',
  ];
  
  final List<String> _genders = ['male', 'female'];
  
  final List<String> _ageGroups = [
    '1-9',
    '10-17',
    '18-25',
    '26-35',
    '36-45',
    '46-55',
    '56+',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Guest Group',
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
                IconButton(
                  onPressed: widget.onCancel,
                  icon: Icon(Icons.close, color: AppColors.textLight),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Nationality
            DropdownButtonFormField<String>(
              initialValue: _nationality,
              decoration: InputDecoration(
                labelText: 'Nationality',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: _nationalities.map((nationality) {
                return DropdownMenuItem(value: nationality, child: Text(nationality));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _nationality = value;
                  _isPhilippines = value == 'Philippines';
                  if (!_isPhilippines) {
                    _philippinesRegion = null;
                  }
                });
              },
              validator: (value) => value == null ? 'Please select nationality' : null,
            ),
            const SizedBox(height: 12),
            
            // Philippines Region (conditional)
            if (_isPhilippines)
              Column(
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _philippinesRegion,
                    decoration: InputDecoration(
                      labelText: 'Region (Philippines)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    items: _philippinesRegions.map((region) {
                      return DropdownMenuItem(value: region, child: Text(region));
                    }).toList(),
                    onChanged: (value) => setState(() => _philippinesRegion = value),
                    validator: (value) {
                      if (_isPhilippines && value == null) {
                        return 'Please select region';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            
            // Gender
            DropdownButtonFormField<String>(
              initialValue: _gender,
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: _genders.map((gender) {
                return DropdownMenuItem(value: gender, child: Text(gender.toUpperCase()));
              }).toList(),
              onChanged: (value) => setState(() => _gender = value),
              validator: (value) => value == null ? 'Please select gender' : null,
            ),
            const SizedBox(height: 12),
            
            // Age Group
            DropdownButtonFormField<String>(
              initialValue: _ageGroup,
              decoration: InputDecoration(
                labelText: 'Age Group',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: _ageGroups.map((ageGroup) {
                return DropdownMenuItem(value: ageGroup, child: Text(ageGroup));
              }).toList(),
              onChanged: (value) => setState(() => _ageGroup = value),
              validator: (value) => value == null ? 'Please select age group' : null,
            ),
            const SizedBox(height: 12),
            
            // Count
            TextFormField(
              initialValue: '1',
              decoration: InputDecoration(
                labelText: 'Number of Guests',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _count = int.tryParse(value) ?? 1;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) return 'Please enter count';
                if (int.tryParse(value) == null) return 'Please enter a valid number';
                if (int.parse(value) < 1) return 'Count must be at least 1';
                return null;
              },
            ),
            const SizedBox(height: 20),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onCancel,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: AppColors.border),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final breakdown = {
                          'nationality': _nationality,
                          'region': _isPhilippines ? _philippinesRegion : null,
                          'gender': _gender,
                          'age_group': _ageGroup,
                          'count': _count,
                        };
                        widget.onSubmit(breakdown);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Add Group'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}