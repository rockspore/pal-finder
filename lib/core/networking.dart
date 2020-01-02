import 'dart:convert';
import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:pal_finder/main.dart';

class Networking {
  Networking._internal() {
    if (Platform.isIOS) {
      _host = 'http://localhost:8000';
    } else if (Platform.isAndroid) {
      _host = 'http://10.0.2.2:8000';
    }
  }

  factory Networking() {
    if (_singleton == null) {
      _singleton = Networking._internal();
    }
    return _singleton;
  }

  static Networking _singleton;
  String _authToken;
  String _host;

  String get host => _host;

  loginUser(String username, String password) async {
    String loginUrl;
    if (Platform.isIOS) {
      loginUrl = '$host/api-token/';
    } else if (Platform.isAndroid) {
      loginUrl = '$host/api-token/';
    }
    try {
      final response = await http.post(
        loginUrl,
        body: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        _authToken = data['token'];
      } else {
        throw('Failed login: ${response.statusCode}.');
      }
    } catch(err) {
      throw('Failed to connect: $err');
    }
  }

  // static _promptLogin() {
  //   navigatorKey.currentState.pushNamedAndRemoveUntil(
  //     '/login',
  //     (Route<dynamic> route) => false,
  //   );
  // }

  Map<String, String> _injectAuthToken(Map<String, String> headers) {
    headers['authorizationHeader'] = 'Token $_authToken';
    return headers;
  }
  
  get(url, {Map<String, String> headers: const{}}) => http.get(
      url,
      headers: _injectAuthToken(headers),
    );

  post(url, {Map<String, String> headers, body, Encoding encoding}) => http.post(
    url,
    headers: _injectAuthToken(headers),
    body: body,
    encoding: encoding,
  );

  put(url, {Map<String, String> headers, body, Encoding encoding}) => http.put(
    url,
    headers: _injectAuthToken(headers),
    body: body,
    encoding: encoding,
  );

}
