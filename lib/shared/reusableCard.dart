import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableCard extends StatefulWidget {
  final String cardDescription;
  final IconData cardIcon;
  final String navigationRoute;

  const ReusableCard({
    this.cardDescription = 'No Description',
    this.cardIcon = FontAwesomeIcons.faceSadCry,
    this.navigationRoute = '/',
  });

  @override
  State<ReusableCard> createState() => _ReusableCardState();
}

class _ReusableCardState extends State<ReusableCard> {
  @override
  Widget build(BuildContext context) {
    double heightofscreen = MediaQuery.of(context).size.height;

    return Expanded(
      child: GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(context, widget.navigationRoute).then((_) {
            if (mounted) {
              setState(() {});
            }
          });
        },
        child: Container(
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.lightBlue[600],
            borderRadius: const BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: heightofscreen / 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      widget.cardIcon,
                      size: heightofscreen / 25,
                      color: Colors.purple,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  widget.cardDescription,
                  style: GoogleFonts.acme(fontSize: 25.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
