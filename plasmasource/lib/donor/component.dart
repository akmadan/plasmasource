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

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plasmasource/utils/text.dart';

class BloodGroupDONOR extends StatefulWidget {
  static String bloodgroup = 'A+';
  @override
  _BloodGroupDONORState createState() => _BloodGroupDONORState();
}

class _BloodGroupDONORState extends State<BloodGroupDONOR> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: Container(
                child: modified_text(text: 'Blood Group of Donor: ', size: 18)),
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
                  value: BloodGroupDONOR.bloodgroup,
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.transparent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      BloodGroupDONOR.bloodgroup = newValue;
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
// -----------------DONOR NAME----------------------
//
//
//
//
//
//

class PatientNameDONOR extends StatefulWidget {
  static TextEditingController patientnamecontroller =
      new TextEditingController();
  @override
  _PatientNameDONORState createState() => _PatientNameDONORState();
}

class _PatientNameDONORState extends State<PatientNameDONOR> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bold_text(
          text: 'Donor Details',
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
              controller: PatientNameDONOR.patientnamecontroller,
              cursorColor: Theme.of(context).primaryColor,
              style: TextStyle(fontFamily: 'SFPro', fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Donor's Name",
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
// -----------------CONTACT DONOR----------------------
//
//
//
//
//
//

class ContactDONOR extends StatefulWidget {
  static TextEditingController phonecontroller = TextEditingController();
  @override
  _ContactDONORState createState() => _ContactDONORState();
}

class _ContactDONORState extends State<ContactDONOR> {
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
              maxLength: 10,
              keyboardType: TextInputType.phone,
              controller: ContactDONOR.phonecontroller,
              cursorColor: Theme.of(context).primaryColor,
              style: TextStyle(fontFamily: 'SFPro', fontSize: 20),
              decoration: InputDecoration(
                counterText: '',
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

//
//
//
//
//
//
// -----------------Donor Address----------------------
//
//
//
//
//
//

class DonorAddress extends StatefulWidget {
  static TextEditingController phonecontroller = new TextEditingController();
  static TextEditingController addresscontroller = new TextEditingController();
  static String currentAddress;
  static Position currentposition;
  @override
  _DonorAddressState createState() => _DonorAddressState();
}

class _DonorAddressState extends State<DonorAddress> {
  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

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
        DonorAddress.currentposition = position;
        DonorAddress.currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        DonorAddress.addresscontroller.text = DonorAddress.currentAddress;
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
          text: 'Donor Address',
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
              controller: DonorAddress.addresscontroller,
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
