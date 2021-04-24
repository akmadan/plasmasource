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
    String age = AgeGender.agecontrollerdonor.text.toString();
    DateTime dateofpositive = Dateofcovid.selectedDate;
    String donorgender = AgeGender.gender;
    var t = DateTime.now();
    String time = t.toString();
    String doc = time + contact;
    //------------------
    if (patientname != '' &&
        hospitaladdress != '' &&
        contact != '' &&
        age != '') {
      if (int.parse(age) >= 18 && int.parse(age) <= 55) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .collection('mydonations')
            .doc(doc)
            .set({
          'donorname': patientname,
          'bg': bg,
          'doc': doc,
          'age': age,
          'gender': donorgender,
          'donoraddress': hospitaladdress,
          'contact': contact,
          'dop': dateofpositive,
          'latitude': position.latitude,
          'longitude': position.longitude
        });
        FirebaseFirestore.instance.collection('alldonors').doc(doc).set({
          'donorname': patientname,
          'bg': bg,
          'doc': doc,
          'donoraddress': hospitaladdress,
          'contact': contact,
          'age': age,
          'dop': dateofpositive,
          'gender': donorgender,
          'latitude': position.latitude,
          'longitude': position.longitude
        });
        Fluttertoast.showToast(msg: 'You are a Donor');
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: 'Invalid Age');
      }
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
          _showMyDialog();
        },
      )),
      appBar: AppBar(
          title: appbar(
        title: 'Donor Registration',
      )),
      body: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              SizedBox(height: 15),
              PatientNameDONOR(),
              SizedBox(height: 10),
              BloodGroupDONOR(),
              Divider(),
              SizedBox(height: 10),
              AgeGender(),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 10),
              Dateofcovid(),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              DonorAddress(),
              Divider(),
              SizedBox(height: 20),
              ContactDONOR(),
              SizedBox(height: 15),
            ],
          )),
    );
  }

  //------------------------------------------
  //------------------------------------------
  //------------------------------------------
  // //------------------------------------------
  //------------------------------------------
  //------------------------------------------
  // //------------------------------------------
  //------------------------------------------
  //------------------------------------------
  // //------------------------------------------
  //------------------------------------------
  //------------------------------------------

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: bold_text(text: 'Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                modified_text(
                    text:
                        'Patients with HIV, kidney transplant recipients, cancer patients, TB patients, and people who underwent surgery or had a tattoo in the past six months are ineligible.'),
                SizedBox(
                  height: 10,
                ),
                modified_text(
                    text:
                        'Your Name, Address and Contact Details will be shared among others.'),
                SizedBox(
                  height: 10,
                ),
                modified_text(
                    text:
                        'Click Accept if you are eligible & agree to our Terms and Conditions.')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: bold_text(
                size: 16,
                text: 'Accept',
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                becomedonor();
              },
            ),
          ],
        );
      },
    );
  }
}
