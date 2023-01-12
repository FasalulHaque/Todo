import 'package:shared_preferences/shared_preferences.dart';

class SharedPerf {
  Future<void> setUserData(String email, String userId) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('isLogin', true);
    await pref.setString('userId', userId);
    await pref.setString('email', email);
  }

  Future<Map> getUserData() async {
    final pref = await SharedPreferences.getInstance();
    final isLogin = pref.getBool('isLogin');
    final userId = pref.getString('userId');
    final email = pref.getString('email');

    final userData = {'isLogin': isLogin, 'userId': userId, 'email': email};

    return userData;
  }
}
