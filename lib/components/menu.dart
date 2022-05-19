import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preggo/components/listTile.dart';
import 'package:preggo/screens/diet.dart';
import 'package:preggo/screens/exercise_reg.dart';
import 'package:preggo/screens/growth_chart.dart';
import 'package:preggo/screens/home.dart';
import 'package:preggo/screens/resources.dart';
import 'package:preggo/screens/settings.dart';
import 'package:preggo/screens/water_log.dart';

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
            navigationRoute: Homepage.id,
          ),
          MenuTile(
            menuTitle: 'Export Information',
            navigationRoute: Homepage.id,
          ),
          MenuTile(
            menuTitle: 'Resources',
            navigationRoute: Resources.id,
          ),
          MenuTile(
            menuTitle: 'Settings',
            navigationRoute: Settings.id,
          ),
        ],
      ),
    );
  }
}
