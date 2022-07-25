import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/services/database.dart';
import 'package:preggo/shared/constants.dart';
import 'package:provider/provider.dart';

class Resources extends StatelessWidget {
  static const String id = 'resources_screen';

  const Resources({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUID>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resources [Placeholder]"),
        actions: [
          IconButton(
              onPressed: null,
              icon: const Icon(FontAwesomeIcons.affiliatetheme)),
        ],
      ),
      body: Column(
        children: [
          Text(
            'Resource',
            style: kGoogleTitle,
          ),
          Text(
            'Description',
            style: kGoogleDescription,
          ),
          Center(
            child: Image.network(
              'https://i.pinimg.com/736x/af/f9/c1/aff9c15444220ed9832394b21282a39c.jpg',
              height: MediaQuery.of(context).size.height * 0.75,
            ),
          ),
        ],
      ),
    );
  }
}
