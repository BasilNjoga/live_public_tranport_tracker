class Vehicle {
  final int id;
  final String numberplate;
  final String bussacco;
  final String route;
  final double latitude;
  final double longitude;

  const Vehicle({
    required this.id,
    required this.numberplate,
    required this.bussacco,
    required this.route,
    required this.latitude,
    required this.longitude, 
    
   
  });


  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      numberplate: json['number_plate'],
      bussacco: json['bus_sacco'],
      route : json["route"],
      latitude: json["latitude"],
      longitude: json["longitude"],

      );
      }

}
