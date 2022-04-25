import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuListTile extends StatelessWidget {
  final String menuTitle;

  MenuListTile({required this.menuTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        menuTitle,
        style: GoogleFonts.acme(
          fontSize: 30.0,
        ),
      ),
    );
  }
}
