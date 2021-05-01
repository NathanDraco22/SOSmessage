import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static final Preferences _preferences = Preferences._internal();


  Preferences._internal();

  factory Preferences(){
    return _preferences;
  }

  SharedPreferences pref;

  initPreferences()async{
    pref = await SharedPreferences.getInstance();
  }

  get firstInApp{
    return pref.getBool("init")??true;
  }

  set firstInApp (value){
    pref.setBool("init", value);
  }

}