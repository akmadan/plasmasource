import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    String patientname = PatientName.patientnamecontroller.text.toString();
    String bg = BloodGroup.bloodgroup;
    String hospitalname = Hospital.namecontroller.text.toString();
    String hospitaladdress = Hospital.addresscontroller.text.toString();
    String contact = Contact.phonecontroller.text.toString();
    Position position = Hospital.currentposition;
    var t = DateTime.now();
    String time = t.toString();
    String doc = time + contact;
    //------------------
    if (Photo.image == null) {
      //Photo Not Selected
      if (patientname != '' &&
          hospitalname != '' &&
          hospitaladdress != '' &&
          contact != '') {
        FirebaseFirestore.instance.collection('allrequests').doc(doc).set({
          'patientname': patientname,
          'bg': bg,
          'doc': doc,
          'hospitalname': hospitalname,
          'hospitaladdress': hospitaladdress,
          'contact': contact,
          'latitude': position.latitude,
          'prescription': '',
          'longitude': position.longitude
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .collection('myrequests')
            .doc(doc)
            .set({
          'patientname': patientname,
          'bg': bg,
          'doc': doc,
          'hospitalname': hospitalname,
          'hospitaladdress': hospitaladdress,
          'contact': contact,
          'prescription': '',
          'latitude': position.latitude,
          'longitude': position.longitude
        });
        Fluttertoast.showToast(msg: 'Request Placed');
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: 'Please Fill Complete Information');
      }

      //
      //
      //
      //
      //Photo Selected
    } else {
      if (patientname != '' &&
          hospitalname != '' &&
          hospitaladdress != '' &&
          contact != '') {
        final ref = FirebaseStorage.instance
            .ref()
            .child('Prescriptions')
            .child(doc + '.jpg');
        await ref.putFile(Photo.image);
        String url = await ref.getDownloadURL();
        print(url);
        print('done');
        FirebaseFirestore.instance.collection('allrequests').doc(doc).set({
          'patientname': patientname,
          'bg': bg,
          'doc': doc,
          'prescription': url,
          'hospitalname': hospitalname,
          'hospitaladdress': hospitaladdress,
          'contact': contact,
          'latitude': position.latitude,
          'longitude': position.longitude
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .collection('myrequests')
            .doc(doc)
            .set({
          'patientname': patientname,
          'bg': bg,
          'doc': doc,
          'prescription': url,
          'hospitalname': hospitalname,
          'hospitaladdress': hospitaladdress,
          'contact': contact,
          'latitude': position.latitude,
          'longitude': position.longitude
        });
        Fluttertoast.showToast(msg: 'Request Placed');
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: 'Please Fill Complete Information');
      }
    }
  }

//------------------FUNCTIONS-----------------
//------------------FUNCTIONS-----------------
//------------------FUNCTIONS-----------------
//------------------FUNCTIONS-----------------
////------------------FUNCTIONS-----------------
/////------------------FUNCTIONS-----------------
/////------------------FUNCTIONS-----------------
/////------------------FUNCTIONS-----------------
  //------------------FUNCTIONS-----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
          child: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        label: modified_text(text: 'Place Request', size: 18),
        onPressed: () {
          placerequest();
        },
      )),
      appBar: AppBar(
          title: appbar(
        title: 'Create Request for Plasma',
      )),
      body: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              SizedBox(height: 15),
              PatientName(),
              SizedBox(height: 10),
              BloodGroup(),
              Divider(),
              SizedBox(height: 20),
              Hospital(),
              Divider(),
              SizedBox(height: 20),
              Photo(),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Contact(),
              SizedBox(height: 15),
            ],
          )),
    );
  }
}
