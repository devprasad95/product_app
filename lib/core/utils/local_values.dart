import 'package:shared_preferences/shared_preferences.dart';

class LocalValues{
  static late SharedPreferences? prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static setPin(String s) async{
    await prefs!.setString('pin', s);
  }

  static getPin() async {
    String? s = '';
    s = prefs!.getString('pin');
    return s;
  }
  static clearPin()async {
    await prefs!.remove('pin');
  }
}