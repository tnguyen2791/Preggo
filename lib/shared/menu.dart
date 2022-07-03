import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preggo/shared/menuTile.dart';
import 'package:preggo/presentation/screens/all_screens.dart';

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
            menuTitle: 'Weigh-In',
            navigationRoute: GrowthChart.id,
          ),
          MenuTile(
            menuTitle: 'Food Diary',
            navigationRoute: Diet.id,
          ),
          MenuTile(
            menuTitle: 'Water Intake',
            navigationRoute: WaterLog.id,
          ),
          MenuTile(
            menuTitle: 'Exercise',
            navigationRoute: ExerciseRegimen.id,
          ),
          MenuTile(
            menuTitle: 'Blood Sugar Log',
            navigationRoute: Wrapper.id,
          ),
          MenuTile(
            menuTitle: 'Export Information',
            navigationRoute: Wrapper.id,
          ),
          MenuTile(
            menuTitle: 'Resources',
            navigationRoute: Resources.id,
          ),
          MenuTile(
            menuTitle: 'Settings',
            navigationRoute: Settings.id,
          ),
          ListTile(
            title: Text(
              'TestSettings',
              style: GoogleFonts.acme(
                fontSize: 30.0,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Settings()))
                  .then((value) => null);
            },
          )
        ],
      ),
    );
  }
}
