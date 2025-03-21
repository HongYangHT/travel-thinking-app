import 'package:travel_thinking_app/common/utils/utils.dart';

class User {
  final String id;
  final String username;
  final String? email;
  final String? phone;
  final int gender;
  final String? signature;
  final String? avatar;
  // ignore: non_constant_identifier_names
  final String? last_login;
  final String? token;

  User({
    required this.phone,
    required this.gender,
    required this.signature,
    required this.avatar,
    // ignore: non_constant_identifier_names
    required this.last_login,
    required this.email,
    required this.id,
    required this.username,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      phone: isStringNullOrEmpty(json['_phone']) ? '' : json['_phone'],
      gender: json['_gender'],
      signature:
          isStringNullOrEmpty(json['_signature']) ? '' : json['_signature'],
      avatar: isStringNullOrEmpty(json['_avatar']) ? '' : json['_avatar'],
      last_login: json['_last_login'],
      email: isStringNullOrEmpty(json['_email']) ? '' : json['_email'],
      id: json['_id'],
      username: isStringNullOrEmpty(json['_username']) ? '' : json['_username'],
      token: json['_access_token'],
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'username': username,
  //     'email': email,
  //     'phone': phone,
  //     'avatar': avatar,
  //     'last_login': last_login,
  //     'signature': signature,
  //     'gender': gender,
  //   };
  // }
}
