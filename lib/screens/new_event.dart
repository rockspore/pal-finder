import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pal_finder/data/place.dart';
// import 'package:pal_finder/core/networking.dart';

class NewEventScreen extends StatelessWidget {
  // final TextEditingController _usernameController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  final PlaceData placeData;

  NewEventScreen({@required this.placeData});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if(Navigator.canPop(context)) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home',
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.of(context).pushReplacementNamed('/home');
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
                  // SizedBox(height: 45.0),
                  // TextField(
                  //   // controller: _usernameController,
                  //   decoration: InputDecoration(
                  //     hintText: 'Username',
                  //   ),
                  //   style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.bold, ),
                  // ),
                  Text(
                    placeData.placeName,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    placeData.address,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      // TODO: Implement login and get token method
                    },
                    child: Text("Create",
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