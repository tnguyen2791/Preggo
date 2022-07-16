import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/growthscreen/weightlogmodel.dart';
import 'package:provider/provider.dart';
import 'package:preggo/models/user.dart';
import 'weightdatabase.dart';
import 'package:preggo/services/sharedfunctions.dart';

class EditWeightDialogue extends StatefulWidget {
  const EditWeightDialogue({Key? key}) : super(key: key);

  @override
  State<EditWeightDialogue> createState() => _EditWeightDialogueState();
}

class _EditWeightDialogueState extends State<EditWeightDialogue> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUID>(context, listen: false);
    final weightlisttoedit =
        WeightDatabaseServices(uid: user.uid).getListToEdit();

    return AlertDialog(
      title: const Text('Edit your weight'),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: FutureBuilder<List<WeightModel>>(
          future: weightlisttoedit,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {}

            if (snapshot.connectionState == ConnectionState.done) {
              List<WeightModel> retrieveddata =
                  snapshot.data!.cast<WeightModel>();

              List<Widget> todisplay = [];

              for (WeightModel item in retrieveddata) {
                var prettydate = toPrettyDateMMMddyyyy(item.currentweek);
                ListTile thetile = ListTile(
                    leading: Text(prettydate),
                    subtitle: Text(item.weight.toString()),
                    trailing: ElevatedButton(
                      onPressed: () => WeightDatabaseServices(uid: user.uid)
                          .deleteWeight(item.currentweek)
                          .whenComplete(() {
                        setState(() {});
                      }),
                      child: const Icon(FontAwesomeIcons.deleteLeft),
                    ));
                todisplay.add(thetile);
              }
              return SizedBox(
                height: 200,
                width: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: todisplay.length,
                  itemBuilder: ((context, int index) {
                    return ListTile(
                      title: todisplay[index],
                    );
                  }),
                ),
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
