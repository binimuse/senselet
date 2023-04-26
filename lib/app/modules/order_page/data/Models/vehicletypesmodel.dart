// ignore_for_file: non_constant_identifier_names, unnecessary_null_in_if_null_operators

class VehicleTypesModel {
  late final String createdAt;
  late final String description;
  late final String id;
  late final int kg;
  late final String name;
  late final String prefix;
  VehicleTypesModel({
    required this.createdAt,
    required this.description,
    required this.id,
    required this.kg,
    required this.name,
    required this.prefix,
  });

  factory VehicleTypesModel.fromJson(Map<String, dynamic> json) {
    return VehicleTypesModel(
      createdAt: json['createdAt'],
      description: json['description'],
      id: json['id'],
      kg: json['kg'],
      name: json['name'],
      prefix: json['prefix'],
    );
  }
}


