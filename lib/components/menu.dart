import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preggo/components/listTile.dart';

class MenuBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'Menu to App!',
                style: GoogleFonts.acme(
                  fontSize: 30,
                ),
              ),
            ),
          ),
          MenuTile(menuTitle: 'Home'),
          MenuTile(menuTitle: 'Weigh-In'),
          MenuTile(menuTitle: 'Food Diary'),
          MenuTile(menuTitle: 'Water Intake'),
          MenuTile(menuTitle: 'Blood Sugar Log'),
          MenuTile(menuTitle: 'Export Information'),
          MenuTile(menuTitle: 'Resources'),
        ],
      ),
    );
  }
}
