// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pal_finder/core/networking.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String _welcomeString = 'Login:';

  @override
  Widget build(BuildContext context) {
    // print('Building login page... $context');
    return _loginScreen(context);
  }
          
  Widget _loginScreen(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if(Navigator.canPop(context)) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 45.0),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                    ),
                    style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.bold, ),
                  ),
                  SizedBox(height: 25.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.bold, ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => _LoadingScreen(
                            _usernameController.text,
                            _passwordController.text
                          ),
                        ),
                      );
                    },
                    child: Text("LOGIN",
                        style: TextStyle(color: Colors.white,
                            fontSize: 22.0)
                    ),
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

class _LoadingScreen extends StatefulWidget {
  _LoadingScreen(this._username, this._password);

  final String _username;
  final String _password;

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<_LoadingScreen> {
  
  @override
  void initState() {
    super.initState();
    _loginUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          children: <Widget>[
            Expanded(child:
              Container(decoration: BoxDecoration(color: Colors.black),
                alignment: FractionalOffset(0.5, 0.3),
                child: Text("Loading...", style: TextStyle(fontSize: 40.0, color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loginUser(BuildContext context) async {
    try {
      await Networking().loginUser(widget._username, widget._password);
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (Route<dynamic> route) => false,
      );
    } catch(err) {
      // print('Error caught: $err');
      Navigator.pop(context);
    }
  }
}

class SplashScreen extends StatefulWidget {
  final int _splashDuration = 2;

  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  _initApp(BuildContext context) async {
    Future tokenGetter = _storage.read(key: 'auth_token');
    Future timer = Future.delayed(Duration(seconds: widget._splashDuration), () => true);
    GooglePlacesApi();
    final waitRes = await Future.wait([
      tokenGetter,
      timer,
    ]);
    if (waitRes[0] == null) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Networking().authToken = waitRes[0];
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  final _storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _initApp(context);
  }

  @override
  Widget build(BuildContext context) {
    // print('Building splashscreen in $context');
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          children: <Widget>[
            Expanded(child:
              Container(decoration: BoxDecoration(color: Colors.black),
                alignment: FractionalOffset(0.5, 0.3),
                child: Text("Invite", style: TextStyle(fontSize: 40.0, color: Colors.white),),
              ),
            ),
            Container(margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
              child: Text("© Copyright Huge Corp 2020", style: TextStyle(fontSize: 16.0, color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}