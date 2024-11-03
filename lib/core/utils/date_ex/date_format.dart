import 'package:intl/intl.dart';

String formattedDate(DateTime date) {
  DateFormat formatter = DateFormat('dd / MM / yyyy');
  return formatter.format(date);
}
