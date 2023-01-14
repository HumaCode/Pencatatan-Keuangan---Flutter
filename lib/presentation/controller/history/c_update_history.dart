// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';

import 'package:course_money_record/data/model/history.dart';
import 'package:course_money_record/data/source/source_history.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CUpdateHistory extends GetxController {
  // date / input tanggal
  final _date = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  String get date => _date.value;
  setDate(n) => _date.value = n;

  // tipe / input tipe
  final _type = 'Pemasukan'.obs;
  String get type => _type.value;
  setType(n) => _type.value = n;

  // items
  final _items = [].obs;
  List get items => _items.value;

  // menambahkan item
  addItem(n) {
    _items.value.add(n);
    count();
  }

  // menghapus item
  deleteItem(i) {
    _items.value.removeAt(i);
    count();
  }

  // nilai total item
  final _total = 0.0.obs;
  double get total => _total.value;

  // menghitung nila total
  count() {
    _total.value = items.map((e) => e['price']).toList().fold(0.0,
        (previousValue, element) {
      return previousValue + double.parse(element);
    });
    update();
  }

  // initial data update history
  init(idUser, date) async {
    History? history = await SourceHistory.whereDate(idUser, date);
    if (history != null) {
      setDate(history.date);
      setType(history.type);
      _items.value = jsonDecode(history.details!);
      count();
    }
  }
}
