class User {
  final int id;
  final String email;
  final String token;

  const User({
    required this.id,
    required this.email,
    required this.token
  });


  factory User.fromDatabaseJson(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      email: data['email'],
      token: data['token'],
      );
      }

  Map<String, dynamic> toDatabaseJson() => {
        "id": id,
        "email": email,
        "token": token,
      };
}
