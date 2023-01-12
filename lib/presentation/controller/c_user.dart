import 'package:course_money_record/data/model/user.dart';
import 'package:get/get.dart';

class CUser extends GetxController {
  // membuat variabel default dari user (isi user masih null / kosong)
  final _data = User().obs;

  // geter mengambil dari value data user
  User get data => _data.value;

  // setter  perbaharui data.value
  setData(n) => _data.value = n;
}
