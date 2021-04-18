import 'package:flutter/material.dart';
import 'package:plasmasource/componenets/components.dart';
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
  placerequest() async {}
  //------------------FUNCTIONS-----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
          child: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        label: bold_text(text: 'Place Request'),
        onPressed: () {
          print(widget.uid);
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
