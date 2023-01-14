// ignore_for_file: invalid_use_of_protected_member

import 'package:course_money_record/data/model/history.dart';
import 'package:course_money_record/data/source/source_history.dart';
import 'package:get/get.dart';

class CIncomeOutcome extends GetxController {
  final _list = <History>[].obs;
  List<History> get list => _list.value;

  // function get list history
  getList(idUser, type) async {
    _list.value = await SourceHistory.incomeOutcome(idUser, type);
    update();
  }
}