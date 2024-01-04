import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String email;
  String username;
  String fullName;
  String balance;
  String level;
  DateTime lastAc;
  String apiKey;

  ProfileModel({
    required this.email,
    required this.username,
    required this.fullName,
    required this.balance,
    required this.level,
    required this.lastAc,
    required this.apiKey,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        email: json["email"],
        username: json["username"],
        fullName: json["full_name"],
        balance: json["balance"],
        level: json["level"],
        lastAc: DateTime.parse(json["last_ac"]),
        apiKey: json["api_key"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "full_name": fullName,
        "balance": balance,
        "level": level,
        "last_ac": lastAc.toIso8601String(),
        "api_key": apiKey,
      };
}
