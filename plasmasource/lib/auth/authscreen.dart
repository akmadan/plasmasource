import 'package:flutter/material.dart';
import 'package:plasmasource/auth/authform.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
      body: AuthForm(),
    );
  }
}
