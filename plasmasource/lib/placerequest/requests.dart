import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import 'package:plasmasource/placerequest/components.dart';
import 'package:plasmasource/utils/text.dart';
import 'package:plasmasource/utils/widgets.dart';

class Request extends StatefulWidget {
  final String uid;

  const Request({Key key, this.uid}) : super(key: key);
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  //------------------FUNCTIONS-----------------
  placerequest() async {
    String patientname =  PatientName.patientnamecontroller.text.toString();
    String bg = BloodGroup.bloodgroup;
    String hospitalname = Hospital.namecontroller.text.toString();
    String hospitaladdress = Hospital.addresscontroller.text.toString();
    String contact = Contact.phonecontroller.text.toString();
    Position position = Hospital.currentposition;
    var t = DateTime.now();
    String time = t.toString();
    String doc = time + contact;
    //------------------
    if(patientname!='' && hospitalname!='' && hospitaladdress!='' && contact!=''){
FirebaseFirestore.instance.collection('allrequests').doc(doc).set({
      'patientname':patientname,
      'bg': bg,
      'hospitalname': hospitalname,
      'hospitaladdress': hospitaladdress,
      'contact': contact,
  'latitude':position.latitude,
  'longitude':position.longitude
    });
    Fluttertoast.showToast(msg: 'Request Placed');
    }
    else{
      Fluttertoast.showToast(msg: 'Please Fill Complete Information');
    }
    
  }

  //------------------FUNCTIONS-----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
          child: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        label: bold_text(text: 'Place Request'),
        onPressed: () {
          placerequest();
        },
      )),
      appBar: AppBar(
          title: appbar(
        title: 'Create Request for Plasma',
      )),
      body: Container(
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              PatientName(),
              SizedBox(height: 10),
              BloodGroup(),
              Divider(),
              SizedBox(height: 20),
              Hospital(),
              Divider(),
              SizedBox(height: 20),
              Contact()
            ],
          )),
    );
  }
}
