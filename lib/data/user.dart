// import 'dart:core';
import 'package:meta/meta.dart';

class UserData {

  UserData({
    @required this.username,
    @required this.email,
    @required this.firstName,
    @required this.lastName,
    @required this.profilePhotoUrl,
  });

  UserData.fromMap(Map<String, dynamic> map)
      : username = map['username'],
        email = map['email'],
        firstName = map['first_name'],
        lastName = map['last_name'],
        profilePhotoUrl = map['profile']['profile_photo'];

  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String profilePhotoUrl;

  String get fullName => firstName + ' ' + lastName;

  @override
  String toString() {
    return username;
  }

}