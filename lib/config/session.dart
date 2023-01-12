import 'dart:convert';

import 'package:course_money_record/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  // function save sassion/membuat session dari user login
  static Future<bool> saveUser(User user) async {
    final pref = await SharedPreferences.getInstance();

    // mengubah objek jadi map
    Map<String, dynamic> mapUser = user.toJson();

    // mengubah objek map user menjadi string
    String stringUser = jsonEncode(mapUser);

    // masukan kedalam key user, dengan value stringUser
    bool success = await pref.setString('user', stringUser);

    return success;
  }

  // function mengambil data sassion dari user login
  static Future<User> getUser() async {
    // buat objek user default
    User user = User();

    // inisialisasi
    final pref = await SharedPreferences.getInstance();

    // mengambil data session
    String? stringUser = pref.getString('user');

    // cek jika tidak null
    if (stringUser != null) {
      // ubah kebentuk map
      Map<String, dynamic> mapUser = jsonDecode(stringUser);
      user = User.fromJson(mapUser);
    }

    return user;
  }

  // function delete sassion dari user login
  static Future<bool> clearUser() async {
    final pref = await SharedPreferences.getInstance();

    // remove data user
    bool success = await pref.remove('user');

    return success;
  }
}
