import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plasmasource/allrequests/requestbubble.dart';

class All extends StatefulWidget {
  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('allrequests').snapshots(),
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
    );
  }
}
