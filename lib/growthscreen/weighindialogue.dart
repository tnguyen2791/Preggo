import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:preggo/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/services/sharedfunctions.dart';

class WeighInDialogueAlert extends StatefulWidget {
  const WeighInDialogueAlert({Key? key}) : super(key: key);

  @override
  State<WeighInDialogueAlert> createState() => _WeighInDialogueAlertState();
}

class _WeighInDialogueAlertState extends State<WeighInDialogueAlert> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUID>(context, listen: false);

    Future logWeight1(List loggedweight, String uid) async {
      final CollectionReference childingCollection =
          FirebaseFirestore.instance.collection('childing');
      await childingCollection.doc(uid).update({
        'loggedweight': FieldValue.arrayUnion(loggedweight),
      });
    }

    TextEditingController weightcontroller = TextEditingController();

    var formKey = GlobalKey<FormState>();

    String loggedweight = '098';
    int selectedDate = DateTime.now().millisecondsSinceEpoch;

    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Text(
          'Log Current Weight',
          textAlign: TextAlign.center,
          style: kGoogleTitle.copyWith(color: Colors.black),
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: const BoxDecoration(),
                          child: Text('Current Date',
                              style: kGoogleDescription.copyWith(
                                  color: Colors.black)),
                        ),
                        ListTile(
                            leading: const Icon(FontAwesomeIcons.calendar),
                            trailing: Text(toPrettyDateMMMddyyyy(selectedDate)),
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 270)),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 10)),
                                currentDate: DateTime.now(),
                                cancelText: "Cancel",
                              ).then((date) {
                                if (date == null) {
                                  return null;
                                } else {
                                  selectedDate = date.millisecondsSinceEpoch;
                                  // print(DateTime.fromMillisecondsSinceEpoch(
                                  //     selectedDate));
                                  return selectedDate;
                                }
                              }).whenComplete(() {
                                setState(() {
                                  selectedDate;
                                });
                              });
                            }),
                        Text('Weight',
                            style: kGoogleDescription.copyWith(
                                color: Colors.black)),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: weightcontroller,
                          onChanged: (value) {
                            loggedweight = value;
                            // print(loggedweight);
                          },
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                (!value.contains(
                                  RegExp(r'(^[0-9]*$)'),
                                )) ||
                                int.parse(value) > 600) {
                              return 'Error in input';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // print(selectedDate);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Go Back',
                        style: kGoogleDescription,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          List toImport = [
                            {
                              'time': selectedDate,
                              'weight': int.parse(loggedweight)
                            }
                          ];
                          loggedweight = weightcontroller.value.text;
                          logWeight1(toImport, user.uid);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'LOG IT',
                        style: kGoogleDescription,
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      );
    });
  }
}
