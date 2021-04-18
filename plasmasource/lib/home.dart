import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plasmasource/utils/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String useruid = '';
  String name = '';
  getuserdata() async {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid.toString();
    setState(() {
      useruid = uid;
    });
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(useruid).get();
    setState(() {
      name = snapshot['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(uid:useruid),
      floatingActionButton: floating(uid:useruid),
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
