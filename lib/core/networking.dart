import 'dart:convert';
import 'dart:io';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pal_finder/main.dart';

class Networking {
  Networking._internal(this._authToken);

  factory Networking() {
    if (_singleton == null) {
      _promptLogin();
    }
    return _singleton;
  }

  static Networking _singleton = null;
  final String _authToken;

  static loginUser(String username, String password) async {
    String loginUrl;
    if (Platform.isIOS) {
      loginUrl = 'http://localhost:8000/api-token/';
    } else if (Platform.isAndroid) {
      loginUrl = 'http://10.0.2.2:8000/api-token/';
    }
    final response = await http.post(
      loginUrl,
      body: {
        'username': username,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      _singleton = Networking._internal(data['token']);
    } else {
      throw Exception('Failed login: ${response.statusCode}.');
    }
  }

  static _promptLogin() {
    navigatorKey.currentState.pushNamedAndRemoveUntil(
      '/login',
      (Route<dynamic> route) => false,
    );
  }
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
