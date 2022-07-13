class LoginDetails {
  String username;
  String password;

  LoginDetails(this.username, this.password);

  @override
  String toString() {
    return this.toJson().toString();
  }

  Map<String, dynamic> toJson() {
    return {"username": username, "password": password};
  }

  dynamic myEncode(dynamic item) {
    return item;
  }
}
