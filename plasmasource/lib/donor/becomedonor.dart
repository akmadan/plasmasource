import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plasmasource/donor/component.dart';
import 'package:plasmasource/utils/text.dart';
import 'package:plasmasource/utils/widgets.dart';

class BecomeDonor extends StatefulWidget {
  final String uid;

  const BecomeDonor({Key key, this.uid}) : super(key: key);
  @override
  _BecomeDonorState createState() => _BecomeDonorState();
}

class _BecomeDonorState extends State<BecomeDonor> {
  becomedonor() async {
    String patientname = PatientNameDONOR.patientnamecontroller.text.toString();
    String bg = BloodGroupDONOR.bloodgroup;
    String hospitaladdress = DonorAddress.addresscontroller.text.toString();
    String contact = ContactDONOR.phonecontroller.text.toString();
    Position position = DonorAddress.currentposition;
    var t = DateTime.now();
    String time = t.toString();
    String doc = time + contact;
    //------------------
    if (patientname != '' && hospitaladdress != '' && contact != '') {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection('mydonations')
          .doc(doc)
          .set({
        'donorname': patientname,
        'bg': bg,
        'doc': doc,
        'donoraddress': hospitaladdress,
        'contact': contact,
        'latitude': position.latitude,
        'longitude': position.longitude
      });
      FirebaseFirestore.instance.collection('alldonors').doc(doc).set({
        'donorname': patientname,
        'bg': bg,
        'doc': doc,
        'donoraddress': hospitaladdress,
        'contact': contact,
        'latitude': position.latitude,
        'longitude': position.longitude
      });
      Fluttertoast.showToast(msg: 'You are a Donor');
    } else {
      Fluttertoast.showToast(msg: 'Please Fill Complete Information');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
          child: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        label: modified_text(text: 'Become Donor', size: 18),
        onPressed: () {
          becomedonor();
        },
      )),
      appBar: AppBar(
          title: appbar(
        title: 'Donor Registration',
      )),
      body: Container(
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              PatientNameDONOR(),
              SizedBox(height: 10),
              BloodGroupDONOR(),
              Divider(),
              SizedBox(height: 20),
              DonorAddress(),
              Divider(),
              SizedBox(height: 20),
              ContactDONOR()
            ],
          )),
    );
  }
}
