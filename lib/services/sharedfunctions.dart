import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String toPrettyDateMMMddyyyy(int epochvalue) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(epochvalue);
  DateFormat formatter = DateFormat('MMM-dd-yyyy');
  String formatted = formatter.format(date);
  return formatted;
}
