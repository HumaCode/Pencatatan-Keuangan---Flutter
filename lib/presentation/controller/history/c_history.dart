// ignore_for_file: invalid_use_of_protected_member

import 'package:course_money_record/data/model/history.dart';
import 'package:course_money_record/data/source/source_history.dart';
import 'package:get/get.dart';

class CHistory extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;

  final _list = <History>[].obs;
  List<History> get list => _list.value;

  // function get list history
  getList(idUser) async {
    _loading.value = true;
    update();

    _list.value = await SourceHistory.history(idUser);
    update();

    Future.delayed(const Duration(milliseconds: 900), () {
      _loading.value = false;
      update();
    });
  }

  // function search list history
  search(idUser, date) async {
    _loading.value = true;
    update();

    _list.value = await SourceHistory.historySearch(idUser, date);
    update();

    Future.delayed(const Duration(milliseconds: 900), () {
      _loading.value = false;
      update();
    });
  }
}
