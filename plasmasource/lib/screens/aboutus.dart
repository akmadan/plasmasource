import 'package:flutter/material.dart';
import 'package:plasmasource/utils/text.dart';
import 'package:plasmasource/utils/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'benzenellc@gmail.com',
      queryParameters: {'subject': 'Feedback/Contact/Bug Report'});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appbar(
          title: 'About Us',
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(children: [
          modified_text(
              size: 20,
              text: '\n' +
                  'We were dedicated to make this app after seeing our friends, teachers, families requesting for plasma across various platforms & realizing the need of such platform.' +
                  '\n\n' +
                  'Recently, requests for plasma donation have increased across social media with people asking for help for their near ones who have tested coronavirus positive. It is very much challenging to find the right donor with same blood group around you.' +
                  '\n\n' +
                  'Our mission is to make this process a bit simpler & easier. On our platform, a plasma donor can register himself with all his contact details so that it becomes easier for the recipient to contact the right donor. A recipient can request for plasma as well.' +
                  '\n\n' +
                  // 'We were dedicated to make this app after seeing our friends, teachers, families requesting for plasma across various platforms & realizing the need of such platform.' +
                  // '\n\n' +
                  // 'Recently, requests for plasma donation have increased across social media with people asking for help for their near ones who have tested coronavirus positive. It is very much challenging to find the right donor with same blood group around you.' +
                  // '\n\n' +
                  // 'Our mission is to make this process a bit simpler & easier. On our platform, a plasma donor can register himself with all his contact details so that it becomes easier for the recipient to contact the right donor. A recipient can request for plasma as well.' +
                  // '\n\n' +
                  'We have tried our best to make the platform bugs free but if you find any please contact us through our email'),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              launch(_emailLaunchUri.toString());
            },
            child: Container(
                child: Row(
              children: [
                Icon(Icons.email),
                SizedBox(width: 10),
                bold_text(size: 18, text: 'benzenellc@gmail.com')
              ],
            )),
          )
        ]),
      ),
    );
  }
}
