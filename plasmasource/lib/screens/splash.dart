import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plasmasource/screens/nolocation.dart';
import 'dart:async';

import 'package:plasmasource/utils/text.dart';

import 'check.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _mockCheckForSession();
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    bool permission = await Geolocator.isLocationServiceEnabled();
    if (permission) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Check()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => NoLocation()));
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      image: DecorationImage(
                          image: AssetImage('assets/logo.png'))),
                ),
                SizedBox(height: 15),
                bold_text(
                    text: 'PlasmaSource', color: Colors.grey[700], size: 20),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Center(
              child: bold_text(
                  text: 'By Benzene',
                  size: 18,
                  color: Theme.of(context).primaryColor),
            ),
          ),
        ]),
      ),
    ));
  }
}
