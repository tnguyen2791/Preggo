import 'package:shared_preferences/shared_preferences.dart';

addStringToSP(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

addInttoSP(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

addDoubletoSP(String key, double value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble(key, value);
}

addBooltoSP(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

getIntfromSP(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int intfromsp = prefs.getInt(key) ?? 0;
  return intfromsp;
}

getStringfromSP(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringfromsp = prefs.getString(key) ?? 'No data';
  return stringfromsp;
}

getBoolfromSP(String key) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool boolfromsp = pref.getBool(key) ?? false;
  return boolfromsp;
}

getDoublefromSP(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  double doublefromsp = prefs.getDouble(key) ?? 0.0;
  return doublefromsp;
}
