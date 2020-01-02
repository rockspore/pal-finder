import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  final int splashDuration = 2;

  _startTimer(BuildContext context) async {
    return Timer(
        Duration(seconds: splashDuration),
            () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          Navigator.of(context).pushReplacementNamed('/login');
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    _startTimer(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          children: <Widget>[
            Expanded(child:
              Container(decoration: BoxDecoration(color: Colors.black),
                alignment: FractionalOffset(0.5, 0.3),
                child: Text("TestApp", style: TextStyle(fontSize: 40.0, color: Colors.white),),
              ),
            ),
            Container(margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
              child: Text("© Copyright Statement 2018", style: TextStyle(fontSize: 16.0, color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}