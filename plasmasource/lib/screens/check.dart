import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plasmasource/auth/authscreen.dart';

import '../home.dart';

class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(), //1
            builder: (context, usersnapshot) {
              if (usersnapshot.hasData) {
                return Home();
              } else {
                return AuthScreen();
              }
            }));
  }
}
