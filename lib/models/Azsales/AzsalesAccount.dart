class AzsalesAccount {
  String _displayName;
  String _username;
  String _email;
  String _role;
  String accessToken;

  //GETTER
  get displayName => _displayName;
  get username => _username;
  get email => _email;
  get role => _role;

  AzsalesAccount({
    String displayName,
    String username,
    String role,
    String email,
    this.accessToken,
  }) {
    _displayName = displayName;
    _username = username;
    _email = email;
    _role = role;
  }

  factory AzsalesAccount.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> userData = json['userData'];
    return AzsalesAccount(
      displayName: userData['display_name'],
      username: userData['username'],
      role: userData['user_role'],
      email: userData['email'],
      accessToken: json['accessToken'],
    );
  }
}
