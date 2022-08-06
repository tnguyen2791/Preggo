import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<void> sendFeedback() async {
  String loadedEmailBody =
      await rootBundle.loadString('assets/texts/feedbackemailbody.txt');

  bool isHTML = false;

  final recipientController = TextEditingController(
    text: 'tnguyen2791@gmail.com',
  );

  final subjectController =
      TextEditingController(text: 'Lets Help You Improve Childing!');

  final bodyController = TextEditingController(
    text: loadedEmailBody,
  );

  final Email email = Email(
    body: bodyController.text,
    subject: subjectController.text,
    recipients: [recipientController.text],
    isHTML: isHTML,
  );

  print(email.body);

  try {
    await FlutterEmailSender.send(email);
  } catch (error) {
    print(error);
  }
}
