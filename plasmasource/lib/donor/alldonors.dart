import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plasmasource/donor/donorbubble.dart';
import 'package:plasmasource/utils/text.dart';
import 'package:plasmasource/utils/widgets.dart';

class AllDonors extends StatefulWidget {
  final String useruid;

  const AllDonors({Key key, this.useruid}) : super(key: key);
  @override
  _AllDonorsState createState() => _AllDonorsState();
}

class _AllDonorsState extends State<AllDonors> {
  String bloodgroup = 'All Donors';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floating_donor(uid: widget.useruid),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
                      'All Donors',
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
            ],
          ),
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('alldonors')
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
                        if (bloodgroup == 'All Donors') {
                          if (DateTime.now()
                                  .difference(docs[index]['dop'].toDate())
                                  .inDays <=
                              40) {
                            return DonorBubble(
                              isme: false,
                              name: docs[index]['donorname'],
                              bg: docs[index]['bg'],
                              donoraddress: docs[index]['donoraddress'],
                              contact: docs[index]['contact'],
                              lat: docs[index]['latitude'],
                              lon: docs[index]['longitude'],
                              age: docs[index]['age'],
                              gender: docs[index]['gender'],
                            );
                          }
                        } else {
                          if (docs[index]['bg'] == bloodgroup) {
                            if (DateTime.now()
                                    .difference(docs[index]['dop'].toDate())
                                    .inDays <=
                                40) {
                              return DonorBubble(
                                isme: false,
                                name: docs[index]['donorname'],
                                bg: docs[index]['bg'],
                                donoraddress: docs[index]['donoraddress'],
                                contact: docs[index]['contact'],
                                lat: docs[index]['latitude'],
                                lon: docs[index]['longitude'],
                                age: docs[index]['age'],
                                gender: docs[index]['gender'],
                              );
                            }
                          } else {
                            return Container();
                          }
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
