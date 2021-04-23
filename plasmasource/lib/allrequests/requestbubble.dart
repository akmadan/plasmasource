import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import 'package:plasmasource/utils/text.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class RequestBubble extends StatefulWidget {
  final bool ismine;
  static String distance = '';
  final String name, uid, doc, hospitaladdress, hospitalname, contact, bg;
  final double lat, lon;

  const RequestBubble(
      {Key key,
      this.name,
      this.hospitaladdress,
      this.hospitalname,
      this.contact,
      this.bg,
      this.lat,
      this.lon,
      this.ismine,
      this.uid,
      this.doc})
      : super(key: key);
  @override
  _RequestBubbleState createState() => _RequestBubbleState();
}

class _RequestBubbleState extends State<RequestBubble> {
  @override
  void initState() {
    super.initState();
    getdistance();
  }

  deleterequest() async {
    await FirebaseFirestore.instance
        .collection('allrequests')
        .doc(widget.doc)
        .delete();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .collection('myrequests')
        .doc(widget.doc)
        .delete();
    Fluttertoast.showToast(msg: 'Request Deleted');
  }

  getdistance() async {
    Position myposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double distanceInMeters = Geolocator.distanceBetween(
            myposition.latitude, myposition.longitude, widget.lat, widget.lon) /
        1000;
    setState(() {
      RequestBubble.distance = distanceInMeters.toStringAsFixed(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.ismine == false) {
          showAlertDialog(context);
        }
      },
      child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            bold_text(
                              text: widget.name,
                              size: 20,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            modified_text(
                              text: widget.hospitalname,
                              size: 18,
                            ),
                            modified_text(
                              text: widget.hospitaladdress,
                              size: 18,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            !widget.ismine
                                ? Container(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: modified_text(
                                      text: RequestBubble.distance + ' km away',
                                      size: 18,
                                    ))
                                : Container()
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(160),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.8),
                        ),
                        child: Center(
                            child: bold_text(
                          text: widget.bg,
                          size: 18,
                          color: Colors.white,
                        )),
                      )
                    ],
                  ),
                ),
              ),
              widget.ismine
                  ? InkWell(
                      onTap: () {
                        deleterequest();
                      },
                      child: Card(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(15),
                            child: Center(
                                child: modified_text(
                              text: 'Withdraw',
                              color:Colors.white,
                              size: 20,
                            ))),
                      ),
                    )
                  : Container()
            ],
          )),
    );
  }

  //----------------------------------------------------
  // //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //   //----------------------------------------------------
  // //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //   //----------------------------------------------------
  // //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------
  //  //----------------------------------------------------

  showAlertDialog(BuildContext context) {
    Widget callbutton = Row(
      children: [
        Container(
          width: 120,
          height: 50,
          child: InkWell(
            onTap: () async {
              await UrlLauncher.launch("tel://" + widget.contact.toString());
            },
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: modified_text(
                    text: 'Call',
                    size: 20,
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ),
        Container(
          width: 120,
          height: 50,
          child: InkWell(
            onTap: () async {
              await Share.share(widget.name +
                  ' requires ' +
                  widget.bg +
                  ' blood Plasma Urgently. Contact: ' +
                  widget.contact +
                  '\n' +
                  'Download Plasma Source App to Place Plasma Request or to become a Donor. Your one donation will affect many lives.' +
                  '\n' +
                  'http://play.google.com/store/apps/details?id=com.benzene.plasmasource1');
            },
            child: Card(
              color: Theme.of(context).primaryColor,
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child:
                    modified_text(text: 'Share', size: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );

    AlertDialog alert = AlertDialog(
      title: bold_text(
        text: widget.name,
        size: 24,
      ),
      content: Container(
        height: 280,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            modified_text(text: 'Blood Group: ' + widget.bg, size: 18),
            Divider(),
            bold_text(text: 'Contact', size: 20),
            modified_text(text: widget.contact, size: 18),
            Divider(),
            bold_text(text: 'Hospital Info', size: 20),
            modified_text(text: widget.hospitalname, size: 18),
            modified_text(text: widget.hospitaladdress, size: 18),
          ],
        ),
      ),
      actions: [
        callbutton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
