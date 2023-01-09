part of 'models.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.avatar,
    required this.googleId,
    required this.registrationId,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String? avatar;
  String? googleId;
  String? registrationId;
  String name;
  String email;
  DateTime? emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      avatar: json['avatar'],
      googleId: json['google_id'],
      registrationId: json['registrationId'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'] == null
          ? null
          : DateTime.parse(json['email_verified_at']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'avatar': avatar,
      'google_id': googleId,
      'registration_id': registrationId,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt?.toString(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}
