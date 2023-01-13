import 'package:course_money_record/config/api.dart';
import 'package:course_money_record/config/api_request.dart';
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
        DInfo.dialogError('Register Gagal..!!');
        DInfo.closeDialog();
      }
    }

    return responseBody['success'];
  }
}
