import 'package:intl/intl.dart';

class Hooks {
  static String formmatingDateTime(DateTime date) {
    return DateFormat('yy.MM.dd').format(date);
  }
}
