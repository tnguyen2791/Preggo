import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/loginscreen/login.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/presentation/screens/loading_screen.dart';
import 'package:preggo/presentation/screens/wrapper.dart';
import 'package:preggo/presentation/settings/weighselection.dart';
import 'package:preggo/services/auth.dart';
import 'package:preggo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:preggo/shared/constants.dart';
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
                          const Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Hero(
                              tag: 'logo',
                              child: CircleAvatar(
                                  radius: 90.0,
                                  backgroundImage:
                                      AssetImage('assets/icon/icon.png')),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                                leading: const Icon(
                                  FontAwesomeIcons.calendar,
                                  color: Colors.white,
                                ),
                                title: FittedBox(
                                  child: Text(
                                    'Baby\'s due date:',
                                    style: kGoogleDescription,
                                  ),
                                ),
                                trailing: Text(
                                  toPrettyDateMMMddyyyy(userData.epochduedate),
                                  style: kGoogleDescription,
                                ),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const Icon(
                                FontAwesomeIcons.person,
                                color: Colors.white,
                              ),
                              title: FittedBox(
                                child: Text(
                                  'Weigh-In Option',
                                  style: kGoogleDescription,
                                ),
                              ),
                              trailing: const WeighSelection(),
                            ),
                          ),
                          if (userData.weighpref == "Regular")
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onFieldSubmitted: (value) {
                                    weight = value;
                                  },
                                  style: kGoogleDescription,
                                  onEditingComplete: () {
                                    weight = weightController.text;
                                  },
                                  controller: weightController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    icon: const Icon(
                                      FontAwesomeIcons.weightScale,
                                      color: Colors.white,
                                    ),
                                    hintText: 'Enter Pre-Pregnancy Weight',
                                    labelText: 'Pre-Pregnancy Weight (lbs)',
                                    labelStyle: kGoogleDescription,
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onFieldSubmitted: (value) {
                                    height = value;
                                  },
                                  onEditingComplete: () {
                                    height = heightController.text;
                                  },
                                  style: kGoogleDescription,
                                  controller: heightController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    icon: const Icon(
                                      FontAwesomeIcons.ruler,
                                      color: Colors.white,
                                    ),
                                    hintText: 'Enter Height',
                                    labelText: 'Height in inches',
                                    labelStyle: kGoogleDescription,
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onEditingComplete: () {
                                  email = provideremailController.text;
                                },
                                controller: provideremailController,
                                style: kGoogleDescription,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  icon: const Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Enter your provider e-mail',
                                  labelText: 'Doctor\'s Email',
                                  labelStyle: kGoogleDescription,
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
                              CheckboxFormField(
                                  title: Text('I agree with the disclaimer',
                                      style: kGoogleDescription),
                                  onSaved: (newValue) => null,
                                  validator: (value) {
                                    if (value != true) {
                                      return 'Please agree with the disclaimer before continuing';
                                    }
                                    return null;
                                  }),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const DisclaimerAlertDialogue();
                                        }),
                                    child: const Text('View Disclaimer'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKeyforDataCollection
                                          .currentState!
                                          .validate()) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                          'Welcome!',
                                          style: kGoogleDescription,
                                          textAlign: TextAlign.center,
                                        )));
                                        DatabaseService(uid: user.uid)
                                            .updateemail(provideremailController
                                                .value.text);
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
                                    child: const Text('SUBMIT'),
                                  ),
                                ],
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
