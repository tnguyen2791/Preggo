import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preggo/shared/menuTile.dart';
import 'package:preggo/presentation/screens/all_screens.dart';

class MenuBase extends StatelessWidget {
  const MenuBase({Key? key}) : super(key: key);

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
          const MenuTile(
            menuTitle: 'Weigh-In',
            navigationRoute: GrowthChart.id,
          ),
          const MenuTile(
            menuTitle: 'Food Diary',
            navigationRoute: Diet.id,
          ),
          const MenuTile(
            menuTitle: 'Water Intake',
            navigationRoute: WaterLog.id,
          ),
          const MenuTile(
            menuTitle: 'Exercise',
            navigationRoute: ExerciseRegimen.id,
          ),
          const MenuTile(
            menuTitle: 'Blood Sugar Log',
            navigationRoute: Wrapper.id,
          ),
          const MenuTile(
            menuTitle: 'Export Information',
            navigationRoute: Wrapper.id,
          ),
          const MenuTile(
            menuTitle: 'Resources',
            navigationRoute: Resources.id,
          ),
          const MenuTile(
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
                  .push(
                      MaterialPageRoute(builder: (context) => const Settings()))
                  .then((value) => null);
            },
          )
        ],
      ),
    );
  }
}
