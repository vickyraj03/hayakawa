

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? preferences;
  static const String KEY_USER_ID = "Userid";
  static const String KEY_USR_VALIDATE = 'USERVALIDATE';

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }




  static void setUserid(String usrid) async {
    preferences!.setString(KEY_USER_ID, usrid);
  }

  static String? getUserid() {
    String? usrid = preferences!.getString(KEY_USER_ID);
    return usrid;
  }

   

  static void setUserValidate(bool? flag) async {
    preferences!.setBool(KEY_USR_VALIDATE, flag!);
  }

  static bool? getUserValidate() {
    bool? flag = preferences!.getBool(KEY_USR_VALIDATE);
    return flag;
  }

  static String getNetworkIssueMsg() {
    return ('Cannot connect to internet.\n\n Tap to retry.');
  }
}
