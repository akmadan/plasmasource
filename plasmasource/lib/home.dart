import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plasmasource/donor/alldonors.dart';

import 'package:plasmasource/utils/widgets.dart';

import 'allrequests/allrequests.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String useruid = '';
  String name = '';
  @override
  void initState() {
    super.initState();
    getuserdata();
  }

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          drawer: drawer(uid: useruid),
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.local_hospital),
                  text: 'Requests',
                ),
                Tab(
                  icon: Icon(Icons.person_pin_rounded),
                  text: 'Donors',
                ),
              ],
            ),
            title: appbar(title: 'PlasmaSource'),
          ),
          body: TabBarView(children: [
            All(
              useruid: useruid,
            ),
            AllDonors(
              useruid: useruid,
            )
          ])),
    );
  }
}
