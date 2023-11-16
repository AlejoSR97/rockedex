import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import 'package:rockedex/models/user.dart';

class UserProvider extends ChangeNotifier {
  late User currentUser;

  Future<bool> authUser(String username, String password) async {
    bool result = false;

    await http.get(
      Uri.parse('http://192.168.1.6:4000/api/users/auth'),
      headers: {
        'user': username,
        'password': password,
      },
    ).then((response) {
      if (response.statusCode == 200) {
        currentUser = User(
          name: json.json.decode(response.body)['name'],
          password: json.json.decode(response.body)['password'],
          nickname: json.json.decode(response.body)['nickname'],
          team: json.json.decode(response.body)['team'],
        );

        result = true;
      } else {
        result = false;
      }
    });

    return result;
  }

  Future<bool> register(User user) async {
    bool result = false;
    await http
        .post(
      Uri.parse('http://192.168.1.6:4000/api/users'),
      headers: {
        "content-type": "application/json",
      },
      body: json.jsonEncode(user.toJson()),
    )
        .then(
      (response) {
        if (response.statusCode == 200) {
          result = true;
        } else {
          result = false;
        }
      },
    );
    return result;
  }
}
