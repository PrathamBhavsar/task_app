enum DtoAction {
  specific,
  create,
  update,
  delete,
  register,
  login;

  String get action => name;
}
