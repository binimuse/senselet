class ConstantModel {
  String id;
  String address;
  String phone;
  String shortCode;
  int tonePrice;
  String website;

  ConstantModel({
    required this.id,
    required this.address,
    required this.phone,
    required this.shortCode,
    required this.tonePrice,
    required this.website,
  });

  factory ConstantModel.fromJson(Map<String, dynamic> json) => ConstantModel(
        id: json["id"],
        address: json["address"],
        phone: json["phone"],
        shortCode: json["short_code"],
        tonePrice: json["tone_price"],
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "phone": phone,
        "short_code": shortCode,
        "tone_price": tonePrice,
        "website": website,
      };
}
