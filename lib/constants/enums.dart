enum UserRole {
  salesperson,
  admin,
  agency;

  String get role {
    switch (this) {
      case UserRole.salesperson:
        return 'Salesperson';
      case UserRole.admin:
        return 'Admin';
      case UserRole.agency:
        return 'Agency';
    }
  }

  // Convert string to UserRole
  static UserRole fromString(String role) {
    switch (role) {
      case 'Salesperson':
        return UserRole.salesperson;
      case 'Admin':
        return UserRole.admin;
      case 'Agency':
        return UserRole.agency;
      default:
        throw ArgumentError('Invalid user role: $role');
    }
  }
}
