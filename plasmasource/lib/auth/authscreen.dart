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
      body: AuthForm(),
    );
  }
}
