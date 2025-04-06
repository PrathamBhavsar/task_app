enum UserRole {
  owner,
  supervisor,
  manager;

  String get role {
    switch (this) {
      case UserRole.owner:
        return 'Qwner';
      case UserRole.supervisor:
        return 'Supervisor';
      case UserRole.manager:
        return 'Manager';
    }
  }

  // Convert string to UserRole
  static UserRole fromString(String role) {
    switch (role) {
      case 'Owner':
        return UserRole.owner;
      case 'Supervisor':
        return UserRole.supervisor;
      case 'Manager':
        return UserRole.manager;
      default:
        throw ArgumentError('Invalid user role: $role');
    }
  }
}
