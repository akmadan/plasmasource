import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plasmasource/donor/donorbubble.dart';
import 'package:plasmasource/utils/text.dart';
import 'package:plasmasource/utils/widgets.dart';

class MyDonations extends StatefulWidget {
  final String uid;

  const MyDonations({Key key, this.uid}) : super(key: key);
  @override
  _MyDonationsState createState() => _MyDonationsState();
}

class _MyDonationsState extends State<MyDonations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appbar(
          title: 'My Donations',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.uid)
                  .collection('mydonations')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final docs = snapshot.data.docs;
                  if (docs.length == 0) {
                    return Center(child: nodata());
                  } else {
                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return DonorBubble(
                          doc: docs[index]['doc'],
                          uid: widget.uid,
                          isme: true,
                          name: docs[index]['donorname'],
                          bg: docs[index]['bg'],
                          donoraddress: docs[index]['donoraddress'],
                          contact: docs[index]['contact'],
                          lat: docs[index]['latitude'],
                          lon: docs[index]['longitude'],
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
          Container(
            color: Colors.amber.withOpacity(0.4),
            padding: EdgeInsets.all(10),
            child: modified_text(
                text:
                    "Donor will be permanently removed from the Donor's List by clicking on Withdraw Button."),
          )
        ],
      ),
    );
  }
}
