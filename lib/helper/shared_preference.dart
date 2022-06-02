import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  void setLogin(String username, int id_user) async {
    SharedPreferences getPref = await _pref;
    getPref.setBool('isLogin', true);
    getPref.setString('username', username);
    getPref.setInt('id_user', id_user);
  }

  void setLogout() async {
    SharedPreferences getPref = await _pref;
    getPref.setBool('isLogin', false);
    getPref.remove('username');
  }

  Future<String> getUsername() async {
    SharedPreferences getPref = await _pref;
    String username = getPref.getString('username') ?? 'notFound';
    return username;
  }

  Future<int> getIdUser() async {
    SharedPreferences getPref = await _pref;
    int id_user = getPref.getInt('id_user') ?? 999;
    return id_user;
  }

  // Future<int> getFullname() async {
  //   SharedPreferences getPref = await _pref;
  //   int fullname = getPref.getInt('fullname') ?? 'notFound';
  //   return id_user;
  // }

  Future<bool> getLoginStatus() async {
    SharedPreferences getPref = await _pref;
    bool loginStatus = getPref.getBool('isLogin') ?? false;
    return loginStatus;
  }
}