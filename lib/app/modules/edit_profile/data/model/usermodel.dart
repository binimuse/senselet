class UserModel {
  UserModel({
    this.verifiedAt,
    required this.username,
    required this.roles,
    required this.phoneNumber,
    required this.isActive,
    required this.gender,
    required this.firstName,
    required this.id,
    required this.fatherName,
    required this.emailVerified,
    required this.email,
    required this.createdAt,
    required this.birthdate,
  });

  dynamic verifiedAt;
  String username;
  String roles;
  String phoneNumber;
  bool isActive;
  String gender;
  String firstName;
  String id;
  String fatherName;
  bool emailVerified;
  String email;
  DateTime createdAt;
  String birthdate;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      verifiedAt: json['verifiedAt'],
      roles: json['roles'],
      phoneNumber: json['phone_number'],
      isActive: json['isActive'],
      gender: json['gender'],
      firstName: json['first_name'],
      fatherName: json['father_name'],
      emailVerified: json['email_verified'],
      email: json['email'],
      createdAt: json['createdAt'],
      birthdate: json['birthdate'],
    );
  }
}
