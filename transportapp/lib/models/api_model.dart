class UserLogin {
  final String email;
  final String password;

  const UserLogin({
    required this.email,
    required this.password,
  });


 Map <String, dynamic> toDatabaseJson() => {
    "email": email,
    "password": password
  };
}

class Token {
  final String token;

  const Token ({
    required this.token
  });


  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['token'],
      );
  }
}