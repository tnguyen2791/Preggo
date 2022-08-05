import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/loginscreen/login.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/presentation/screens/loading_screen.dart';
import 'package:preggo/presentation/screens/wrapper.dart';
import 'package:preggo/presentation/settings/weighselection.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:preggo/services/sharedfunctions.dart';
import 'package:preggo/shared/restartwidget.dart';
import 'disclaimerdialogue.dart';

class DataCollectionScreen extends StatelessWidget {
  static const String id = 'datacollectionscreen';

  const DataCollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Registration Form';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AuthService().signOut();
                RestartWidget.restartApp(context);
              },
              icon: const Icon(FontAwesomeIcons.powerOff))
        ],
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
  String height = '55';
  String email = 'your@provider.com';

  final GlobalKey<FormState> _formKeyforDataCollection = GlobalKey<FormState>();

  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final provideremailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUID>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
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
                  key: _formKeyforDataCollection,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 1.5,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                                tileColor: Colors.white,
                                leading: const Icon(FontAwesomeIcons.calendar),
                                title: const Text('Baby\'s due date!'),
                                trailing: Text(toPrettyDateMMMddyyyy(
                                    userData.epochduedate)),
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
                                      DatabaseService(uid: user.uid)
                                          .updateDueDate(adate);
                                    }
                                  });
                                }),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ListTile(
                              tileColor: Colors.white,
                              leading: Icon(FontAwesomeIcons.person),
                              title: Text('Weigh-In Option'),
                              trailing: WeighSelection(),
                            ),
                          ),
                          if (userData.weighpref == "Regular")
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
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
                                        (!value
                                            .contains(RegExp(r"^[0-9]*$"))) ||
                                        (int.parse(value) > 400)) {
                                      return 'Invalid input';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ), //below is weight
                          if (userData.weighpref == "Regular")
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextFormField(
                                  onFieldSubmitted: (value) {
                                    height = value;
                                  },
                                  onEditingComplete: () {
                                    height = heightController.text;
                                  },
                                  controller: heightController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    icon: Icon(FontAwesomeIcons.ruler),
                                    hintText: 'Enter Height',
                                    labelText: 'Height in inches',
                                  ),
                                  validator: (String? value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        (!value
                                            .contains(RegExp(r"^[0-9]*$"))) ||
                                        int.parse(value) > 90 ||
                                        40 > int.parse(value)) {
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
                                  hintText:
                                      'Enter your Provider e-mail/contact',
                                  labelText: 'Doctor\'s Email',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    value = 'your@provideremail.com';
                                  } else if ((value.contains(RegExp(
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
                                  if (_formKeyforDataCollection.currentState!
                                      .validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Submitting!')));
                                    DatabaseService(uid: user.uid).updateemail(
                                        provideremailController.value.text);
                                    if (userData.weighpref == "Regular") {
                                      DatabaseService(uid: user.uid)
                                          .updateWeight(int.parse(
                                              weightController.value.text));
                                      DatabaseService(uid: user.uid)
                                          .updateHeight(int.parse(
                                              heightController.value.text));
                                    }
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
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
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
