import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class modified_text extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  const modified_text({Key key, this.text, this.size, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.roboto(fontSize: size, color: color));
  }
}

class bold_text extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  const bold_text({Key key, this.text, this.size, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.roboto(
            fontSize: size, fontWeight: FontWeight.bold, color: color));
  }
}
