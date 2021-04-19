import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plasmasource/screens/check.dart';

class NoLocation extends StatefulWidget {
  @override
  _NoLocationState createState() => _NoLocationState();
}

class _NoLocationState extends State<NoLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(child: Text('Turn On Location')),
          TextButton(
              onPressed: () async {
                bool serviceEnabled;

                serviceEnabled = await Geolocator.isLocationServiceEnabled();
                if (!serviceEnabled) {
                  Fluttertoast.showToast(
                      msg: 'Please enable Your Location Service');
                } else {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Check()));
                }
              },
              child: Text('Next'))
        ],
      ),
    );
  }
}
