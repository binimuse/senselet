class VehicleModel {
  String plateNumber;
  VehicleType vehicleType;
  Location location;
  String id;
  dynamic photos;

  VehicleModel({
    required this.plateNumber,
    required this.vehicleType,
    required this.id,
    required this.location,
    this.photos,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        plateNumber: json["plate_number"],
        vehicleType: VehicleType.fromJson(json["vehicle_type"]),
        location: Location.fromJson(json["location"]),
        id: json["id"],
        photos: json["photos"],
      );

  Map<String, dynamic> toJson() => {
        "plate_number": plateNumber,
        "vehicle_type": vehicleType.toJson(),
        "location": location.toJson(),
        "id": id,
        "photos": photos,
      };
}

class Location {
  String type;

  List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class VehicleType {
  String id;
  String name;
  int kg;
  String description;

  VehicleType({
    required this.id,
    required this.name,
    required this.kg,
    required this.description,
  });

  factory VehicleType.fromJson(Map<String, dynamic> json) => VehicleType(
        id: json["id"],
        name: json["name"],
        kg: json["kg"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "kg": kg,
        "description": description,
      };
}
