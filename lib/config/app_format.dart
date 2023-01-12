import 'package:intl/intl.dart';

class AppFormat {
  // format tanggal indo
  static String date(String stringDate) {
    DateTime dateTime = DateTime.parse(stringDate);

    return DateFormat('d MMM yyyy', 'id_ID').format(dateTime);
  }
}
