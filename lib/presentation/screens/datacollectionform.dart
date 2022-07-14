import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/loginscreen/login.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/presentation/screens/loading_screen.dart';
import 'package:preggo/presentation/screens/wrapper.dart';
import 'package:preggo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:preggo/services/sharedfunctions.dart';
import 'package:flutter/services.dart' show rootBundle;

class DataCollectionScreen extends StatelessWidget {
  static const String id = 'datacollectionscreen';

  const DataCollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Registration Form';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: const DataCollectionWidget(),
    );
  }
}

class DataCollectionWidget extends StatefulWidget {
  const DataCollectionWidget({Key? key}) : super(key: key);

  @override
  State<DataCollectionWidget> createState() => _DataCollectionWidgetState();
}

class _DataCollectionWidgetState extends State<DataCollectionWidget> {
  bool agreeDisclaimer = false;
  String weight = '150';
  String email = 'your@provider.com';

  final weightController = TextEditingController();
  final provideremailController = TextEditingController();

  static final GlobalKey<FormState> formKeyforDataCollection =
      GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUID>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('There is no data');
          }

          if (snapshot.hasData) {
            UserData userData = snapshot.data!;

            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Form(
                key: formKeyforDataCollection,
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 1.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              tileColor: Colors.white,
                              leading: const Icon(FontAwesomeIcons.calendar),
                              title: const Text('Baby\'s due date'),
                              trailing: Text(
                                  toPrettyDateMMMddyyyy(userData.epochduedate)),
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now()
                                            .add(const Duration(days: 90)),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2050))
                                    .then((date) async {
                                  if (date == null) {
                                    return;
                                  } else {
                                    int adate = date.millisecondsSinceEpoch;
                                    // print(adate);
                                    // print(DateTime.fromMillisecondsSinceEpoch(adate));
                                    DatabaseService(uid: user.uid)
                                        .updateDueDate(adate);
                                  }
                                });
                              }),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                weight = value;
                              },
                              onEditingComplete: () {
                                weight = weightController.text;
                              },
                              controller: weightController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                icon: Icon(FontAwesomeIcons.weightScale),
                                hintText: 'Enter Pre-Pregnancy Weight',
                                labelText:
                                    'Prior to Pregnancy Weight in pounds',
                              ),
                              validator: (String? value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    (value.contains(RegExp(r"^[0-9]*$")) ==
                                        false)) {
                                  return 'Invalid input';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onEditingComplete: () {
                                email = provideremailController.text;
                              },
                              controller: provideremailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.email),
                                hintText: 'Enter your Provider e-mail/contact',
                                labelText: 'Doctor\'s Email',
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    (value.contains(RegExp(
                                            r"([a-z0-9!#&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)")) ==
                                        false)) {
                                  return 'Error in input';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const DisclaimerAlertDialogue();
                                  }),
                              child: const Text('View Disclaimer'),
                            ),
                            CheckboxFormField(
                                title:
                                    const Text('I agree with the disclaimer'),
                                onSaved: (newValue) => null,
                                validator: (value) {
                                  if (value != true) {
                                    return 'Please agree with the disclaimer before continuing';
                                  }
                                  return null;
                                }),
                            ElevatedButton(
                              onPressed: () {
                                if (formKeyforDataCollection.currentState!
                                    .validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Submitting!')));
                                  // print(weightController.value.text);
                                  // print(provideremailController.value.text);
                                  DatabaseService(uid: user.uid).updateemail(
                                      provideremailController.value.text);
                                  DatabaseService(uid: user.uid).updateWeight(
                                      int.parse(weightController.value.text));
                                  DatabaseService(uid: user.uid)
                                      .updateagreement(true);
                                  Navigator.of(context)
                                      .pushReplacementNamed(Wrapper.id);
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const LoginScreen();
          }
        });
  }
}

class DisclaimerAgreementCheckbox extends StatefulWidget {
  const DisclaimerAgreementCheckbox({Key? key}) : super(key: key);

  @override
  State<DisclaimerAgreementCheckbox> createState() =>
      _DisclaimerAgreementCheckboxState();
}

class _DisclaimerAgreementCheckboxState
    extends State<DisclaimerAgreementCheckbox> {
  bool agreeDisclaimer = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: agreeDisclaimer,
        onChanged: (bool? value) => setState(() {
              agreeDisclaimer = value!;
            }));
  }
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {Key? key,
      Widget title = const Text('Default Title'),
      required FormFieldSetter<bool> onSaved,
      required FormFieldValidator<bool> validator,
      bool initialValue = false,
      bool autovalidate = false})
      : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                dense: state.hasError,
                title: title,
                value: state.value,
                onChanged: state.didChange,
                subtitle: state.hasError
                    ? Builder(
                        builder: (BuildContext context) => Text(
                          state.errorText!,
                          style: TextStyle(color: Theme.of(context).errorColor),
                        ),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
              );
            });
}

class DisclaimerAlertDialogue extends StatefulWidget {
  const DisclaimerAlertDialogue({Key? key}) : super(key: key);

  @override
  State<DisclaimerAlertDialogue> createState() =>
      _DisclaimerAlertDialogueState();
}

class _DisclaimerAlertDialogueState extends State<DisclaimerAlertDialogue> {
  String _disclaimer = 'error loading';

  @override
  void initState() {
    _loadDisclaimer();
    super.initState();
  }

  Future<void> _loadDisclaimer() async {
    final loadedDisclaimer =
        await rootBundle.loadString('assets/texts/disclaimer.txt');
    setState(() {
      _disclaimer = loadedDisclaimer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Disclaimer'),
      content: SizedBox(
          width: 200,
          height: 400,
          child: ListView(children: [Text(_disclaimer.toString())])),
    );
  }
}
