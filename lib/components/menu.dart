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
          MenuTile(
            menuTitle: 'Home',
            navigationRoute: '/',
          ),
          MenuTile(
            menuTitle: 'Weigh-In',
            navigationRoute: '/',
          ),
          MenuTile(
            menuTitle: 'Food Diary',
            navigationRoute: '/',
          ),
          MenuTile(
            menuTitle: 'Water Intake',
            navigationRoute: '/WaterLog',
          ),
          MenuTile(
            menuTitle: 'Blood Sugar Log',
            navigationRoute: '/',
          ),
          MenuTile(
            menuTitle: 'Export Information',
            navigationRoute: '/',
          ),
          MenuTile(
            menuTitle: 'Resources',
            navigationRoute: '/',
          ),
        ],
      ),
    );
  }
}
