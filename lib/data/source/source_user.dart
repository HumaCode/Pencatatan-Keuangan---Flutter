import 'package:flutter/material.dart';
import 'package:course_money_record/config/api.dart';
import 'package:course_money_record/config/api_request.dart';
import 'package:course_money_record/config/session.dart';
import 'package:course_money_record/data/model/user.dart';
import 'package:d_info/d_info.dart';
import 'package:get/get.dart';

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

  // function register
  static Future<bool> register(
      String name, String email, String password) async {
    // url
    String url = '${Api.user}/register.php';

    // panggil request post, dibuat dalam bentuk map
    Map? responseBody = await AppRequest.post(url, {
      'name': name,
      'email': email,
      'password': password,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    // jika responseBody null
    if (responseBody == null) return false;

    // jika success
    if (responseBody['success']) {
      Get.back();

      // tampilkan dialog
      DInfo.dialogSuccess('Register Berhasil, Silahkan login..');
      DInfo.closeDialog();
    } else {
      if (responseBody['message'] == 'Email') {
        DInfo.dialogError('Email sudah terdaftar');
        DInfo.closeDialog();
      } else {
        DInfo.dialogError('Register Gagal..!!');
        DInfo.closeDialog();
      }
    }

    return responseBody['success'];
  }
}
