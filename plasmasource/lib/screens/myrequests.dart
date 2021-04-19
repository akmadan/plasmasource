import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plasmasource/allrequests/requestbubble.dart';
import 'package:plasmasource/utils/widgets.dart';

class MyRequests extends StatefulWidget {
  final String uid;

  const MyRequests({Key key, this.uid}) : super(key: key);
  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appbar(
          title: 'My Requests',
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .collection('myrequests')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final docs = snapshot.data.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                return RequestBubble(
                  ismine: true,
                  name: docs[index]['patientname'],
                  bg: docs[index]['bg'],
                  hospitalname: docs[index]['hospitalname'],
                  hospitaladdress: docs[index]['hospitaladdress'],
                  contact: docs[index]['contact'],
                  lat: docs[index]['latitude'],
                  lon: docs[index]['longitude'],
                );
              },
            );
          }
        },
      ),
    );
  }
}
