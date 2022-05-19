import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableCard extends StatelessWidget {
  final String cardDescription;
  final IconData cardIcon;
  final String navigationRoute;

  ReusableCard({
    this.cardDescription = 'No Description',
    this.cardIcon = FontAwesomeIcons.faceSadCry,
    this.navigationRoute = '/',
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, navigationRoute);
        },
        child: Container(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  radius: 35.0,
                  backgroundColor: Colors.white,
                  child: Icon(
                    cardIcon,
                    size: 40.0,
                    color: Colors.purple,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  cardDescription,
                  style: GoogleFonts.acme(fontSize: 25.0, color: Colors.white),
                ),
              ),
            ],
          ),
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.lightBlue[600],
            borderRadius: const BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
        ),
      ),
    );
  }
}
