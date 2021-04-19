import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:plasmasource/utils/text.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class DonorBubble extends StatefulWidget {
  final String name, donoraddress, contact, bg;
  final double lat, lon;

  const DonorBubble(
      {Key key,
      this.name,
      this.donoraddress,
      this.contact,
      this.bg,
      this.lat,
      this.lon})
      : super(key: key);
  @override
  _DonorBubbleState createState() => _DonorBubbleState();
}

class _DonorBubbleState extends State<DonorBubble> {
  String distance = '';
  @override
  void initState() {
    super.initState();
    getdistance();
  }

  getdistance() async {
    Position myposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double distanceInMeters = Geolocator.distanceBetween(
            myposition.latitude, myposition.longitude, widget.lat, widget.lon) /
        1000;
    setState(() {
      distance = distanceInMeters.toStringAsFixed(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showAlertDialog(context);
      },
      child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                          text: widget.donoraddress,
                          size: 18,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20)),
                            child: modified_text(
                              text: distance + ' km away',
                              size: 18,
                            ))
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
                      color: Theme.of(context).primaryColor.withOpacity(0.8),
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
                  widget.contact);
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
            modified_text(text: widget.donoraddress, size: 18),
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
