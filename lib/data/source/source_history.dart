import 'package:course_money_record/config/api.dart';
import 'package:course_money_record/config/api_request.dart';
import 'package:course_money_record/data/model/history.dart';
import 'package:d_info/d_info.dart';
import 'package:intl/intl.dart';

class SourceHistory {
  // function analisis
  static Future<Map> analysis(String idUser) async {
    // url
    String url = '${Api.history}/analisis.php';

    // panggil request post, dibuat dalam bentuk map
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'today': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    });

    // jika responseBody null
    if (responseBody == null) {
      return {
        'today': 0.0,
        'yesterday': 0.0,
        'week': [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
        'month': {
          'income': 0.0,
          'outcome': 0.0,
        }
      };
    }

    return responseBody;
  }

  // function add history
  static Future<bool> add(String idUser, String date, String type,
      String details, String total) async {
    // url
    String url = '${Api.history}/add.php';

    // panggil request post, dibuat dalam bentuk map
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'date': date,
      'type': type,
      'details': details,
      'total': total,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    // jika responseBody null
    if (responseBody == null) return false;

    // jika success
    if (responseBody['success']) {
      // tampilkan dialog
      DInfo.dialogSuccess('Berhasil menambahkan history');
      DInfo.closeDialog();
    } else {
      if (responseBody['message'] == 'date') {
        DInfo.dialogError(
            'History dengan tanggal tersebut sudah pernah dibuat.!!');
        DInfo.closeDialog();
      } else {
        DInfo.dialogError('Gagal menambahkan data..!!');
        DInfo.closeDialog();
      }
    }

    return responseBody['success'];
  }

  // function update history
  static Future<bool> update(String idHistory, String idUser, String date,
      String type, String details, String total) async {
    // url
    String url = '${Api.history}/update.php';

    // panggil request post, dibuat dalam bentuk map
    Map? responseBody = await AppRequest.post(url, {
      'id_history': idHistory,
      'id_user': idUser,
      'date': date,
      'type': type,
      'details': details,
      'total': total,
      'updated_at': DateTime.now().toIso8601String(),
    });

    // jika responseBody null
    if (responseBody == null) return false;

    // jika success
    if (responseBody['success']) {
      // tampilkan dialog
      DInfo.dialogSuccess('Berhasil mengubah data history');
      DInfo.closeDialog();
    } else {
      if (responseBody['message'] == 'date') {
        DInfo.dialogError(
            'History dengan tanggal tersebut sudah pernah dibuat.!!');
        DInfo.closeDialog();
      } else {
        DInfo.dialogError('Gagal mengubah data..!!');
        DInfo.closeDialog();
      }
    }

    return responseBody['success'];
  }

  // function delete history
  static Future<bool> delete(String idHistory) async {
    // url
    String url = '${Api.history}/delete.php';

    // panggil request post, dibuat dalam bentuk map
    Map? responseBody = await AppRequest.post(url, {
      'id_history': idHistory,
    });

    // jika responseBody null
    if (responseBody == null) return false;
    return responseBody['success'];
  }

  // function income outcome
  static Future<List<History>> incomeOutcome(String idUser, String type) async {
    // url
    String url = '${Api.history}/income_outcome.php';

    // panggil request post, dibuat dalam bentuk map
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'type': type,
    });

    // jika responseBody null
    if (responseBody == null) return [];

    // cek jika responya success
    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => History.fromJson(e)).toList();
    }

    return [];
  }

  // function income outcome
  static Future<List<History>> incomeOutcomeSearch(
      String idUser, String type, String date) async {
    // url
    String url = '${Api.history}/income_outcome_search.php';

    // panggil request post, dibuat dalam bentuk map
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'type': type,
      'date': date,
    });

    // jika responseBody null
    if (responseBody == null) return [];

    // cek jika responya success
    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => History.fromJson(e)).toList();
    }

    return [];
  }

  // function history
  static Future<List<History>> history(String idUser) async {
    // url
    String url = '${Api.history}/history.php';

    // panggil request post, dibuat dalam bentuk map
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
    });

    // jika responseBody null
    if (responseBody == null) return [];

    // cek jika responya success
    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => History.fromJson(e)).toList();
    }

    return [];
  }

  // function history search
  static Future<List<History>> historySearch(String idUser, String date) async {
    // url
    String url = '${Api.history}/history_search.php';

    // panggil request post, dibuat dalam bentuk map
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'date': date,
    });

    // jika responseBody null
    if (responseBody == null) return [];

    // cek jika responya success
    if (responseBody['success']) {
      List list = responseBody['data'];
      return list.map((e) => History.fromJson(e)).toList();
    }

    return [];
  }

  // function wheredate
  static Future<History?> whereDate(String idUser, String date) async {
    // url
    String url = '${Api.history}/where_date.php';

    // panggil request post, dibuat dalam bentuk map
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'date': date,
    });

    // jika responseBody null
    if (responseBody == null) return null;

    // cek jika responya success
    if (responseBody['success']) {
      var e = responseBody['data'];
      return History.fromJson(e);
    }

    return null;
  }

  // function detail history
  static Future<History?> detail(
      String idUser, String date, String type) async {
    // url
    String url = '${Api.history}/detail.php';

    // panggil request post, dibuat dalam bentuk map
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'date': date,
      'type': type,
    });

    // jika responseBody null
    if (responseBody == null) return null;

    // cek jika responya success
    if (responseBody['success']) {
      var e = responseBody['data'];
      return History.fromJson(e);
    }

    return null;
  }
}
