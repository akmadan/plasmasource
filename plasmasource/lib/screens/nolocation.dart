import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plasmasource/screens/check.dart';
import 'package:plasmasource/utils/text.dart';

class NoLocation extends StatefulWidget {
  @override
  _NoLocationState createState() => _NoLocationState();
}

class _NoLocationState extends State<NoLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 200, width:200, child:
              Image.asset('assets/map.png'),),
            Container(child: bold_text(text:'Your Location seems to be off !', size:20)),
            TextButton(
                onPressed: () async {
                  bool serviceEnabled;

                  serviceEnabled = await Geolocator.isLocationServiceEnabled();
                  if (!serviceEnabled) {
                    Fluttertoast.showToast(
                        msg: 'Please enable Your Location Service');
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Check()));
                  }
                },
                child: modified_text(text:'Next', size: 20,color:Theme.of(context).primaryColor))
          ],
        ),
      ),
    );
  }
}
