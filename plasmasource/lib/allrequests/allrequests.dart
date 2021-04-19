import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plasmasource/allrequests/requestbubble.dart';
import 'package:plasmasource/utils/text.dart';
import 'package:plasmasource/utils/widgets.dart';

class All extends StatefulWidget {
  final String useruid;

  const All({Key key, this.useruid}) : super(key: key);
  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  String bloodgroup = 'A+';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floating_requests(uid: widget.useruid),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade400.withOpacity(0.2),
              ),
              width: 200,
              height: 60.0,
              child: DropdownButton<String>(
                isExpanded: true,
                value: bloodgroup,
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    bloodgroup = newValue;
                  });
                },
                items: <String>[
                  'A+',
                  'A-',
                  'B+',
                  'B-',
                  'AB+',
                  'AB-',
                  'O+',
                  'O-'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: modified_text(text: value, size: 20),
                  );
                }).toList(),
              )),
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('allrequests')
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
                        if (docs[index]['bg'] == bloodgroup) {
                          return RequestBubble(
                            ismine: false,
                            name: docs[index]['patientname'],
                            bg: docs[index]['bg'],
                            hospitalname: docs[index]['hospitalname'],
                            hospitaladdress: docs[index]['hospitaladdress'],
                            contact: docs[index]['contact'],
                            lat: docs[index]['latitude'],
                            lon: docs[index]['longitude'],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
