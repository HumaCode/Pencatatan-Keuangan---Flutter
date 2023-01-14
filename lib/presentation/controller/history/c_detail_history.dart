// ignore_for_file: invalid_use_of_protected_member

import 'package:course_money_record/data/model/history.dart';
import 'package:course_money_record/data/source/source_history.dart';
import 'package:get/get.dart';

class CDetailHistory extends GetxController {
  final _data = History().obs;
  History get data => _data.value;

  // initial data update history
  getData(idUser, date) async {
    History? history = await SourceHistory.whereDate(idUser, date);
    _data.value = history ?? History();
    update();
  }
}
