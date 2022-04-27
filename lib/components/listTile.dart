import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//To supply the menu with proper tiles

class MenuTile extends StatelessWidget {
  final String menuTitle;
  final String navigationRoute;

  MenuTile({required this.menuTitle, required this.navigationRoute});

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
        Navigator.pushNamed(context, navigationRoute);
      },
    );
  }
}
