import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preggo/screens/water_log.dart';

//To supply the menu with proper tiles

class MenuTile extends StatelessWidget {
  final String menuTitle;

  MenuTile({required this.menuTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        menuTitle,
        style: GoogleFonts.acme(
          fontSize: 30.0,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const weighin(),
          ),
        );
      },
    );
  }
}
