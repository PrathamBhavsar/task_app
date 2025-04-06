enum UserRole {
  admin,
  salesperson,
  agency;

  String get role {
    switch (this) {
      case UserRole.admin:
        return 'Admin';
      case UserRole.salesperson:
        return 'Salesperson';
      case UserRole.agency:
        return 'Agency';
    }
  }

  // Convert string to UserRole
  static UserRole fromString(String role) {
    switch (role) {
      case 'Admin':
        return UserRole.admin;
      case 'Salesperson':
        return UserRole.salesperson;
      case 'Agency':
        return UserRole.agency;
      default:
        throw ArgumentError('Invalid user role: $role');
    }
  }
}
