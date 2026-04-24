// lib/ui/business/pages/business_register_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utils/validators.dart';
import '../../../backend/auth/register_handler.dart';

class BusinessRegisterPage extends StatefulWidget {
  const BusinessRegisterPage({super.key});

  @override
  State<BusinessRegisterPage> createState() => _BusinessRegisterPageState();
}

class _BusinessRegisterPageState extends State<BusinessRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _registerHandler = RegisterHandler();
  
  // User Account Fields
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _fullNameController = TextEditingController();
  
  // Business Information Fields
  final _businessNameController = TextEditingController();
  String? _businessType = 'hotel';
  final _ownerNameController = TextEditingController();
  final _permitNumberController = TextEditingController();
  final _registrationNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _businessEmailController = TextEditingController();
  final _totalRoomsController = TextEditingController();
  
  // File paths for documents
  String? _permitFilePath;
  String? _validIdFilePath;
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  
  final List<String> _businessTypes = ['hotel', 'resort', 'inn', 'other'];
  
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    _businessNameController.dispose();
    _ownerNameController.dispose();
    _permitNumberController.dispose();
    _registrationNumberController.dispose();
    _addressController.dispose();
    _contactNumberController.dispose();
    _businessEmailController.dispose();
    _totalRoomsController.dispose();
    super.dispose();
  }
  
  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the terms and conditions')),
      );
      return;
    }
    
    setState(() => _isLoading = true);
    
    final businessData = {
      'username': _usernameController.text.trim(),
      'email': _emailController.text.trim(),
      'password': _passwordController.text,
      'full_name': _fullNameController.text.trim(),
      'business_name': _businessNameController.text.trim(),
      'business_type': _businessType,
      'owner_name': _ownerNameController.text.trim(),
      'permit_number': _permitNumberController.text.trim(),
      'registration_number': _registrationNumberController.text.trim(),
      'address': _addressController.text.trim(),
      'contact_number': _contactNumberController.text.trim(),
      'business_email': _businessEmailController.text.trim(),
      'total_rooms': int.tryParse(_totalRoomsController.text.trim()) ?? 0,
      'permit_file_path': _permitFilePath,
      'valid_id_path': _validIdFilePath,
    };
    
    final result = await _registerHandler.registerBusiness(businessData);
    
    setState(() => _isLoading = false);
    
    if (!mounted) return;
    
    if (result['success']) {
      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Icon(Icons.check_circle, color: AppColors.success, size: 60),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Registration Submitted!',
                style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                'Your application has been submitted for approval. You will receive an email once approved.',
                style: GoogleFonts.inter(fontSize: 14, color: AppColors.textMedium),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Go back to login
              },
              child: Text('Back to Login', style: GoogleFonts.inter(color: AppColors.primary)),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Registration', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withOpacity(0.1),
              AppColors.secondary.withOpacity(0.05),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 40,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.business_center, size: 40, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Register Your Accommodation',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Join San Pablo City Tourism Network',
                          style: GoogleFonts.inter(fontSize: 14, color: AppColors.textMedium),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 24),
                  
                  // Account Information Section
                  Text(
                    'Account Information',
                    style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.primary),
                  ),
                  const SizedBox(height: 20),
                  
                  // Username
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person_outline, color: AppColors.primary),
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                    validator: Validators.validateUsername,
                  ),
                  const SizedBox(height: 16),
                  
                  // Email
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: AppStrings.email,
                      prefixIcon: Icon(Icons.email_outlined, color: AppColors.primary),
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                    validator: Validators.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  
                  // Full Name
                  TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name (Contact Person)',
                      prefixIcon: Icon(Icons.badge_outlined, color: AppColors.primary),
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please enter full name' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  // Password
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: AppStrings.password,
                      prefixIcon: Icon(Icons.lock_outline, color: AppColors.primary),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(height: 16),
                  
                  // Confirm Password
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock_outline, color: AppColors.primary),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                      ),
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please confirm your password';
                      if (value != _passwordController.text) return 'Passwords do not match';
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 24),
                  
                  // Business Information Section
                  Text(
                    'Business Information',
                    style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.primary),
                  ),
                  const SizedBox(height: 20),
                  
                  // Business Name
                  TextFormField(
                    controller: _businessNameController,
                    decoration: InputDecoration(
                      labelText: 'Business Name',
                      prefixIcon: Icon(Icons.store, color: AppColors.primary),
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please enter business name' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  // Business Type
                  DropdownButtonFormField<String>(
                    value: _businessType,
                    decoration: InputDecoration(
                      labelText: 'Business Type',
                      prefixIcon: Icon(Icons.category, color: AppColors.primary),
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                    items: _businessTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _businessType = value),
                  ),
                  const SizedBox(height: 16),
                  
                  // Owner Name
                  TextFormField(
                    controller: _ownerNameController,
                    decoration: InputDecoration(
                      labelText: 'Owner Name',
                      prefixIcon: Icon(Icons.person, color: AppColors.primary),
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please enter owner name' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  // Permit Number
                  TextFormField(
                    controller: _permitNumberController,
                    decoration: InputDecoration(
                      labelText: 'Permit Number',
                      prefixIcon: Icon(Icons.assignment, color: AppColors.primary),
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Registration Number
                  TextFormField(
                    controller: _registrationNumberController,
                    decoration: InputDecoration(
                      labelText: 'Registration Number',
                      prefixIcon: Icon(Icons.numbers, color: AppColors.primary),
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Address
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Business Address',
                      prefixIcon: Icon(Icons.location_on, color: AppColors.primary),
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                    maxLines: 2,
                    validator: (value) => value == null || value.isEmpty ? 'Please enter address' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  // Contact Number
                  TextFormField(
                    controller: _contactNumberController,
                    decoration: InputDecoration(
                      labelText: 'Contact Number',
                      prefixIcon: Icon(Icons.phone, color: AppColors.primary),
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please enter contact number' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  // Business Email
                  TextFormField(
                    controller: _businessEmailController,
                    decoration: InputDecoration(
                      labelText: 'Business Email',
                      prefixIcon: Icon(Icons.email, color: AppColors.primary),
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                    validator: Validators.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  
                  // Total Rooms
                  TextFormField(
                    controller: _totalRoomsController,
                    decoration: InputDecoration(
                      labelText: 'Total Rooms / Units',
                      prefixIcon: Icon(Icons.hotel, color: AppColors.primary),
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter total rooms';
                      if (int.tryParse(value) == null) return 'Please enter a valid number';
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 24),
                  
                  // Document Upload Section (Simulated)
                  Text(
                    'Business Documents',
                    style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.primary),
                  ),
                  const SizedBox(height: 16),
                  
                  // Permit File Upload
                  _buildDocumentUploadButton(
                    label: 'Business Permit',
                    filePath: _permitFilePath,
                    onPressed: () async {
                      // Simulate file picker
                      setState(() {
                        _permitFilePath = 'permit_${DateTime.now().millisecondsSinceEpoch}.pdf';
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Valid ID Upload
                  _buildDocumentUploadButton(
                    label: 'Valid ID of Owner',
                    filePath: _validIdFilePath,
                    onPressed: () async {
                      // Simulate file picker
                      setState(() {
                        _validIdFilePath = 'valid_id_${DateTime.now().millisecondsSinceEpoch}.jpg';
                      });
                    },
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Terms and Conditions
                  Row(
                    children: [
                      Checkbox(
                        value: _agreeToTerms,
                        onChanged: (value) => setState(() => _agreeToTerms = value ?? false),
                        activeColor: AppColors.primary,
                      ),
                      Expanded(
                        child: Text(
                          'I agree to the Terms and Conditions and confirm that all information provided is accurate.',
                          style: GoogleFonts.inter(fontSize: 13, color: AppColors.textMedium),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                            )
                          : Text(
                              'Submit Registration',
                              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Back to Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ", style: GoogleFonts.inter(fontSize: 14, color: AppColors.textMedium)),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 0)),
                        child: Text("Sign In", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildDocumentUploadButton({
    required String label,
    required String? filePath,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
        color: AppColors.background,
      ),
      child: Row(
        children: [
          Icon(filePath == null ? Icons.upload_file : Icons.check_circle, color: filePath == null ? AppColors.textMedium : AppColors.success),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500)),
                if (filePath != null)
                  Text(filePath, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textLight)),
              ],
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(filePath == null ? 'Upload' : 'Replace', style: GoogleFonts.inter(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}