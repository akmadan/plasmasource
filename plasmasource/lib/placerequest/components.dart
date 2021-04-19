import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plasmasource/utils/text.dart';

//
//
//
//
//
//
// -----------------BLOOD GROUP----------------------
//
//
//
//
//
//

class BloodGroup extends StatefulWidget {
  static String bloodgroup = 'A+';
  @override
  _BloodGroupState createState() => _BloodGroupState();
}

class _BloodGroupState extends State<BloodGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: Container(
                child:
                    modified_text(text: 'Blood Group of Patient: ', size: 18)),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400.withOpacity(0.2),
                ),
                width: MediaQuery.of(context).size.width,
                height: 60.0,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: BloodGroup.bloodgroup,
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.transparent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      BloodGroup.bloodgroup = newValue;
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
          ),
        ],
      ),
    );
  }
}

//
//
//
//
//
//
// -----------------PATIENT NAME----------------------
//
//
//
//
//
//

class PatientName extends StatefulWidget {
  static TextEditingController patientnamecontroller =
      new TextEditingController();
  @override
  _PatientNameState createState() => _PatientNameState();
}

class _PatientNameState extends State<PatientName> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bold_text(
          text: 'Patient Details',
          size: 24,
          color: Colors.grey[700],
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade400.withOpacity(0.2),
          ),
          padding: EdgeInsets.all(10),
          height: 70,
          child: Center(
            child: TextField(
              controller: PatientName.patientnamecontroller,
              cursorColor: Theme.of(context).primaryColor,
              style: TextStyle(fontFamily: 'SFPro', fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Patient's Name",
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//
//
//
//
//
//
// -----------------HOSPITAL----------------------
//
//
//
//
//
//

class Hospital extends StatefulWidget {
  static TextEditingController namecontroller = new TextEditingController();
  static TextEditingController phonecontroller = new TextEditingController();
  static TextEditingController addresscontroller = new TextEditingController();
  static String currentAddress;
  static Position currentposition;
  @override
  _HospitalState createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {
  //-----------------------------
  Future<Position> _determinePosition() async {
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

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        Hospital.currentposition = position;
        Hospital.currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        Hospital.addresscontroller.text = Hospital.currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bold_text(
          text: 'Hospital Details',
          size: 24,
          color: Colors.grey[700],
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade400.withOpacity(0.2),
          ),
          padding: EdgeInsets.all(10),
          height: 70,
          child: Center(
            child: TextField(
              controller: Hospital.namecontroller,
              cursorColor: Theme.of(context).primaryColor,
              style: TextStyle(fontFamily: 'SFPro', fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Hospital Name",
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade400.withOpacity(0.2),
          ),
          padding: EdgeInsets.all(10),
          height: 70,
          child: Center(
            child: TextField(
              controller: Hospital.addresscontroller,
              cursorColor: Theme.of(context).primaryColor,
              style: TextStyle(fontFamily: 'SFPro', fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Address",
              ),
            ),
          ),
        ),
        Container(
            child: TextButton(
          onPressed: () {
            _determinePosition();
          },
          child: modified_text(
              text: 'Take Current Address',
              color: Theme.of(context).primaryColor),
        )),
      ],
    );
  }
}

//
//
//
//
//
//
// -----------------CONTACT----------------------
//
//
//
//
//
//

class Contact extends StatefulWidget {
  static TextEditingController phonecontroller = TextEditingController();
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bold_text(
          text: 'Contact Details',
          size: 24,
          color: Colors.grey[700],
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade400.withOpacity(0.2),
          ),
          padding: EdgeInsets.all(10),
          height: 70,
          child: Center(
            child: TextField(
              keyboardType: TextInputType.phone,
              controller: Contact.phonecontroller,
              cursorColor: Theme.of(context).primaryColor,
              style: TextStyle(fontFamily: 'SFPro', fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Contact No.",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
