import 'package:intl/intl.dart';

extension DateEx on DateTime {
  String get toFormattedDate => '$day / $month / $year';

  String get getDaysName {
    DateFormat formatter = DateFormat('E');
    return formatter.format(this);
  }

  String get dayName {
    List<String> daysName = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return daysName[weekday - 1];
  }
}
