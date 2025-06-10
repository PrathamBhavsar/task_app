enum UserRole {
  admin,
  salesperson,
  agent;

  String get role {
    switch (this) {
      case UserRole.admin:
        return 'Admin';
      case UserRole.salesperson:
        return 'Salesperson';
      case UserRole.agent:
        return 'Agent';
    }
  }

  // Convert string to UserRole
  static UserRole fromString(String role) {
    switch (role) {
      case 'Admin':
        return UserRole.admin;
      case 'Salesperson':
        return UserRole.salesperson;
      case 'Agent':
        return UserRole.agent;
      default:
        throw ArgumentError('Invalid user role: $role');
    }
  }
}
