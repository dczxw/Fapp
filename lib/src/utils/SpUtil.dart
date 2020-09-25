import 'package:shared_preferences/shared_preferences.dart';



class SpUtil{
  static SharedPreferences preferences;
  static Future<bool> getInstance() async{
    preferences = await SharedPreferences.getInstance();
    return true;
  }
}










Future getInt(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt(key);
}

Future getString(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future getBool(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key);
}

Future setBool(String key,bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool(key,value);
}

Future setInt(String key,int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setInt(key,value);
}

Future setString(String key,String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString(key,value);
}