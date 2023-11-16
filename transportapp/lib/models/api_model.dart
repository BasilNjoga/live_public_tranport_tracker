class UserLogin {
  String email;
  String password;

  UserLogin({
    required this.email,
    required this.password});

  Map <String, dynamic> toDatabaseJson() => {
    "email": email,
    "password": password
  };
}

class Token{
  final String refresh;
  final String access;

  Token({
    required this.refresh,
    required this.access});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      refresh: json['refresh'],
      access: json['access'],

    );
  }
}

