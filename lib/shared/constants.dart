import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle kGoogleTitle = GoogleFonts.acme(
  fontSize: 40.0,
  color: Colors.white,
);

TextStyle kGoogleDescription = GoogleFonts.acme(
  fontSize: 25.0,
  color: Colors.white,
);

const textInputDecoration = InputDecoration(
  hintText: 'input data here',
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);
