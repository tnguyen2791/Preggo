import 'package:intl/intl.dart';

String toPrettyDateMMMddyyyy(int epochvalue) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(epochvalue);
  DateFormat formatter = DateFormat('MMM-dd-yyyy');
  String formatted = formatter.format(date);
  return formatted;
}

String daysLefttoDueDate(int epochduedate) {
  final DateTime dbuserinDT = DateTime.fromMillisecondsSinceEpoch(epochduedate);
  final Duration difference = dbuserinDT.difference(DateTime.now());

  String date = '${difference.inDays.toString()} days left!';
  return date;
}
