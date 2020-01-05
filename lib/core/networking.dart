import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Networking {
  Networking._internal() {
    // TODO: I specified 'NGI77B dev-keys' as it's the operating system version on my Smartisan Phone.
    if (Platform.isIOS || Platform.operatingSystemVersion == 'NGI77B dev-keys') {
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
    final loginUrl = '$host/api-token/';
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
        try {
          await FlutterSecureStorage().write(key: 'auth_token', value: _authToken);
        } catch (err) {
          print('Error trying to save auth_token.');
        }
      } else {
        throw('Failed to login: ${response.statusCode}.');
      }
    } catch(err) {
      throw('Failed to connect: $err');
    }
  }

  set authToken(String token) => _authToken = token;

  Map<String, String> _injectAuthToken(Map<String, String> headers) {
    if (headers == null) {
      headers = Map<String, String>();
    }
    headers['Authorization'] = 'Token $_authToken';
    return headers;
  }
  
  get(url, {Map<String, String> headers}) => http.get(
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

  void handleResponseCode(BuildContext context, int code) {
    switch (code) {
      case 200:
        break;
      case 401:
        print('401 Unothorized.');
        Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
        break;
      default:
        throw Exception('HTTP error code: $code.');
    }
  }

}

class GooglePlacesApi {
  GooglePlacesApi._internal() {
    _host = 'maps.googleapis.com';
    _apiKey = DotEnv().env['PLACES_API_KEY'];
  }

  factory GooglePlacesApi() {
    if (_singleton == null) {
      _singleton = GooglePlacesApi._internal();
    }
    return _singleton;
  }

  static GooglePlacesApi _singleton;
  String _apiKey;
  String _host;

  String photoUrl(String photoReference, {int maxWidth=1200, int maxHeight}) {
    final Map<String, String> params = {
      'maxwidth': maxWidth.toString(),
      'photoreference': photoReference,
      'key': _apiKey,
    };
    if (maxHeight != null) {
      params['maxheight'] = maxHeight.toString();
    }
    return Uri.https(
      _host,
      '/maps/api/place/photo',
      params,
    ).toString();
  }

  Future<Map> placeDetails(String placeId) async {
    final response = await http.get(
      Uri.https(
        _host,
        '/maps/api/place/details/json',
        {
          'place_id': placeId,
          'key': _apiKey,
        },
      ),
    );
    if (response.statusCode != 200) {
      throw Exception('Error getting place details: ${response.statusCode}');
    }
    final data = jsonDecode(response.body) as Map;
    return data['result'];
  }

}
