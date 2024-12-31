enum UserRoles {
  salesperson,
  admin,
  agency;

  String get role {
    switch (this) {
      case UserRoles.salesperson:
        return 'salesperson';
      case UserRoles.admin:
        return 'admin';
      case UserRoles.agency:
        return 'agency';
    }
  }
}
