class Passenger {
  final int id;
  final String name;
  final String email;

  const Passenger({
    required this.id,
    required this.name,
    required this.email,
  });


  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      );
  }
}