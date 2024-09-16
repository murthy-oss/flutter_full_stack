import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferencesmanager{
  static  SharedPreferences? _prefs;

  static Future<void>init()async{
    _prefs=await SharedPreferences.getInstance();
  }
  static SharedPreferences? get instance=>_prefs;
  //save user id
  static Future<void>saveUid(String uid) async{
    print("uid$uid");
    await _prefs?.setString('uid', uid);
  }
  static String getUid(){
    print('temp:${_prefs?.getString('uid')}');
    return _prefs?.getString('uid') ?? '';
  }
}