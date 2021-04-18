import 'package:flutter/material.dart';
import 'package:plasmasource/utils/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      floatingActionButton: floating(),
      appBar: AppBar(
        title: appbar(title: 'PlasmaSource'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(),
      ),
    );
  }
}
