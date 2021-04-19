import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plasmasource/donor/becomedonor.dart';
import 'package:plasmasource/placerequest/requests.dart';

import 'package:plasmasource/utils/text.dart';
import 'package:share/share.dart';

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

class floating_requests extends StatelessWidget {
  final String uid;

  const floating_requests({Key key, this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).primaryColor,
            label: modified_text(text: 'Create Request', size: 18),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Request(uid: uid)));
            }));
  }
}

class floating_donor extends StatelessWidget {
  final String uid;

  const floating_donor({Key key, this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).primaryColor,
            label: modified_text(text: 'Become Donor', size: 18),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BecomeDonor(uid: uid)));
            }));
  }
}

class drawer extends StatelessWidget {
  final String uid;

  const drawer({Key key, this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
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
                    text: 'My Requests',
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
                  leading: Icon(Icons.share),
                  title: modified_text(
                    text: 'Share',
                    size: 17,
                  ),
                  onTap: () async {
                    await Share.share(
                        'Download PlasmaSource App and help Humanity come out of this Hard Time of COVID-19 ' +
                            'http://play.google.com/store/apps/details?id=com.benzene.plasmasource');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: modified_text(
                    text: 'Rate Us',
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
                  leading: Icon(Icons.local_post_office),
                  title: modified_text(
                    text: 'About Us',
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
          ),
          Container(
              padding: EdgeInsets.all(5),
              child: Center(
                child: bold_text(
                  text: 'By Benzene',
                  size: 16,
                  color: Theme.of(context).primaryColor,
                ),
              ))
        ],
      ),
    );
  }
}
