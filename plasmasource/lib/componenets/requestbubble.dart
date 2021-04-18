import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import 'package:plasmasource/utils/text.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class RequestBubble extends StatefulWidget {
  final String name, hospitaladdress, hospitalname, contact, bg;
  final double lat, lon;

  const RequestBubble(
      {Key key,
      this.name,
      this.hospitaladdress,
      this.hospitalname,
      this.contact,
      this.bg,
      this.lat,
      this.lon})
      : super(key: key);
  @override
  _RequestBubbleState createState() => _RequestBubbleState();
}

class _RequestBubbleState extends State<RequestBubble> {
  String distance = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdistance();
  }

  getdistance() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

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

  showAlertDialog(BuildContext context) {
    Widget remindButton = Container(
      width: 200,
      height: 50,
      child: InkWell(
        onTap: () async {
          await UrlLauncher.launch("tel://" + widget.contact.toString());
        },
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: modified_text(
                text: 'Call', size: 20, color: Theme.of(context).primaryColor),
          ),
        ),
      ),
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
        remindButton,
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
