class ConstantModel {
  String id;
  String address;
  String phone;
  String shortCode;
  int tonePrice;
  String website;
  String fb_id;
  String telegram_id;
  String about_us;

  ConstantModel({
    required this.id,
    required this.address,
    required this.phone,
    required this.shortCode,
    required this.tonePrice,
    required this.website,
    required this.fb_id,
    required this.telegram_id,
    required this.about_us,
  });

  factory ConstantModel.fromJson(Map<String, dynamic> json) => ConstantModel(
        id: json["id"],
        address: json["address"],
        phone: json["phone"],
        shortCode: json["short_code"],
        tonePrice: json["tone_price"],
        fb_id: json["fb_id"],
        telegram_id: json["telegram_id"],
        about_us: json["about_us"],
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "phone": phone,
        "short_code": shortCode,
        "tone_price": tonePrice,
        "website": website,
        "about_us": about_us,
        "telegram_id": telegram_id,
        "fb_id": fb_id,
      };
}
