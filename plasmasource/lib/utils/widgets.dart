import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plasmasource/screens/location.dart';

import 'package:plasmasource/screens/request.dart';
import 'package:plasmasource/utils/text.dart';

class appbar extends StatelessWidget {
  final String title;

  const appbar({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: modified_text(
        text: title,
        color: Colors.white,
      ),
    );
  }
}

class floating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).primaryColor,
            label: bold_text(text: 'Create Request'),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Request()));
            }));
  }
}

class drawer extends StatelessWidget {
  final String uid;
  final String username;
  final String email, aname;

  const drawer({Key key, this.uid, this.username, this.email, this.aname})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              child: Image.asset('assets/girl.png', fit: BoxFit.cover),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: modified_text(
              text: 'Profile',
              size: 17,
            ),
            // onTap: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => ProfileScreen(
            //                 uid: uid,
            //                 username: username,
            //                 email: email,
            //                 aname: aname,
            //               )));
            // },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: modified_text(
              text: 'Starred Messages',
              size: 17,
            ),
            // onTap: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => StarredScreen(
            //                 uid: uid,
            //               )));
            // },
          ),
          ListTile(
            leading: Icon(Icons.person_add_alt_1),
            title: modified_text(
              text: 'Connect Requests',
              size: 17,
            ),
            // onTap: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => ConnectRequestsScreen(
            //                 uid: uid,
            //               )));
            // },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: modified_text(
              text: 'Logout',
              size: 17,
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
