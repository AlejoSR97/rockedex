import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String name;
  String password;
  String nickname;
  String team;

  User({
    required this.name,
    required this.password,
    required this.nickname,
    required this.team,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        password: json["password"],
        nickname: json["nickname"],
        team: json["team"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
        "nickname": nickname,
        "team": team,
      };
}
