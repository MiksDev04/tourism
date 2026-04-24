enum UserRole {
  admin,
  business,
}

// Add this extension to parse string to enum
extension UserRoleExtension on UserRole {
  static UserRole fromString(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return UserRole.admin;
      case 'business':
        return UserRole.business;
      default:
        return UserRole.business;
    }
  }
  
  String get value {
    switch (this) {
      case UserRole.admin:
        return 'admin';
      case UserRole.business:
        return 'business';
    }
  }
}