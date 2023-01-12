import 'package:course_money_record/config/api.dart';
import 'package:course_money_record/config/api_request.dart';
import 'package:course_money_record/config/session.dart';
import 'package:course_money_record/data/model/user.dart';

class SourceUser {
  // function login
  static Future<bool> login(String email, String password) async {
    // url
    String url = '${Api.user}/login.php';

    // panggil request post, dibuat dalam bentuk map
    Map? responseBody = await AppRequest.post(url, {
      'email': email,
      'password': password,
    });

    // jika responseBody null
    if (responseBody == null) return false;

    // jika success
    if (responseBody['success']) {
      var mapUser = responseBody['data'];

      // masukan kedalam session
      Session.saveUser(User.fromJson(mapUser));
    }

    return responseBody['success'];
  }
}
