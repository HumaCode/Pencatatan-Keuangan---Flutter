import 'package:course_money_record/config/api.dart';
import 'package:course_money_record/config/api_request.dart';
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
}
