import 'package:flutter/material.dart';

class FullImage extends StatelessWidget {
  final String photourl;

  const FullImage({Key key, this.photourl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Image.network(
        photourl,
        fit: BoxFit.cover,
      )),
    );
  }
}
