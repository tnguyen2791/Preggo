import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableCard extends StatelessWidget {
  final Color colour;
  final String cardDescription;
  final Icon cardIcon;
  final String navigationRoute;

  ReusableCard({
    required this.colour,
    required this.cardDescription,
    required this.cardIcon,
    required this.navigationRoute,
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
                child: cardIcon,
              ),
              Expanded(
                flex: 2,
                child: Text(
                  cardDescription,
                  style: GoogleFonts.acme(fontSize: 25.0),
                ),
              ),
            ],
          ),
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: colour,
            borderRadius: const BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
        ),
      ),
    );
  }
}
