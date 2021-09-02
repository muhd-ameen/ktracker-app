import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences _preferences;
  static const _loginKey = 'isLoggedIn';
  static const _keyUsername = 'username';
  static const _keyMail = 'MailId';
  static const _keyPhone = 'Phone';
  static const _keyLocation = 'Location';
  static const _keyNickName = 'nickName';

  //
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  //
  // static Future SetUser(bool user) async =>
  //     await _preferences.setBool(_loginKey, user);

  // static bool getUser() => _preferences.getBool(_loginKey);
  static Future setUserName(String username) async =>
    await _preferences.setString(_keyUsername, username);

  static String getUsername() => _preferences.getString(_keyUsername);


  static Future setMail(String mailId) async =>
      await _preferences.setString(_keyMail, mailId);

  static String getMail() => _preferences.getString(_keyMail);


  static Future setPhone(String phone) async =>
      await _preferences.setString(_keyPhone, phone);

  static String getPhone() => _preferences.getString(_keyPhone);

  static Future setLocation(String location)async =>
      await _preferences.setString(_keyLocation, location);

  static String getLocation() => _preferences.getString(_keyLocation);

  static Future setNickname(String Nickname)async =>
      await _preferences.setString(_keyNickName, Nickname);

  static String getNickname() => _preferences.getString(_keyNickName);



}
