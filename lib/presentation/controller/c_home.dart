import 'package:course_money_record/data/source/source_history.dart';
import 'package:get/get.dart';

class CHome extends GetxController {
  final _today = 0.0.obs; // pengeluaran hari ini
  double get today => _today.value;

  final _todayPercent = '0'.obs; // presentase hari ini
  String get todayPercent => _todayPercent.value;

  // pengeluaran minggu ini
  final _week = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0].obs;
  List<double> get week => _week.value;

  List<String> get days => ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
  List<String> weekText() {
    DateTime today = DateTime.now();
    return [
      days[today.subtract(const Duration(days: 6)).weekday - 1],
      days[today.subtract(const Duration(days: 5)).weekday - 1],
      days[today.subtract(const Duration(days: 4)).weekday - 1],
      days[today.subtract(const Duration(days: 3)).weekday - 1],
      days[today.subtract(const Duration(days: 2)).weekday - 1],
      days[today.subtract(const Duration(days: 1)).weekday - 1],
      days[today.weekday - 1],
    ];
  }

  // pengeluaran hari ini
  getAnalisis(String idUser) async {
    Map data = await SourceHistory.analysis(idUser);
    _today.value = data['today'].toDouble();

    // ambil nilai yesterday
    double yesterday = data['yesterday'].toDouble();
    double different = (today - yesterday).abs();
    bool isSame = today.isEqual(yesterday);
    bool isPlus = today.isGreaterThan(yesterday);
    double byYesterday = yesterday == 0 ? 1 : yesterday;
    double percent = (different / byYesterday) * 100;
    _todayPercent.value = isSame
        ? '100% sama dengan kemarin'
        : isPlus
            ? '+${percent.toStringAsFixed(1)}% dibanding kemarin'
            : '-${percent.toStringAsFixed(1)}% dibanding kemarin';

    _week.value = data['yesterday'].map((e) => e.toDouble()).toList();
  }
}
