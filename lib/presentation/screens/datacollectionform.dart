import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preggo/models/user.dart';
import 'package:preggo/presentation/screens/wrapper.dart';
import 'package:preggo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:preggo/userhome/userhome.dart';
import 'package:provider/provider.dart';
import 'package:preggo/services/sharedfunctions.dart';

class DataCollectionScreen extends StatelessWidget {
  static const String id = 'datacollectionscreen';

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Registration Form';

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: DataCollectionWidget(),
    );
  }
}

class DataCollectionWidget extends StatefulWidget {
  @override
  State<DataCollectionWidget> createState() => _DataCollectionWidgetState();
}

class _DataCollectionWidgetState extends State<DataCollectionWidget> {
  final _weightController = TextEditingController();
  bool agreeDisclaimer = false;

  var _weight;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUID>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data!;
            final _formKey = GlobalKey<FormState>();
            final weightController = TextEditingController();
            final provideremailController = TextEditingController();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ListTile(
                            leading: const Icon(FontAwesomeIcons.calendar),
                            title: const Text('Baby\'s due date'),
                            trailing: Text(
                                toPrettyDateMMMddyyyy(userData.epochduedate)),
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
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
                        TextFormField(
                          controller: weightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            icon: Icon(FontAwesomeIcons.weightScale),
                            hintText: 'Enter Pre-Pregnancy Weight',
                            labelText: 'Prior to Pregnancy Weight in pounds',
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
                        TextFormField(
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
                        CheckboxFormField(
                            title: const Text('I agree with the disclaimer'),
                            onSaved: (newValue) => null,
                            validator: (value) {
                              if (value != true) {
                                return 'Please agree with the disclaimer before continuing';
                              }
                              return null;
                            }),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Submitting!')));
                              print(weightController.value.text);
                              print(provideremailController.value.text);
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
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
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
      {Widget title = const Text('Default Title'),
      required FormFieldSetter<bool> onSaved,
      required FormFieldValidator<bool> validator,
      bool initialValue = false,
      bool autovalidate = false})
      : super(
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
