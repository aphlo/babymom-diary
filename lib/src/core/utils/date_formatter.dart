import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static const _weekdayMap = {
    1: '月',
    2: '火',
    3: '水',
    4: '木',
    5: '金',
    6: '土',
    7: '日',
  };

  static String yyyyMM(DateTime date) {
    return DateFormat('yyyy年MM月').format(date);
  }

  static String yyyy(DateTime date) {
    return DateFormat('yyyy年').format(date);
  }

  static String yyyyMMddE(DateTime date) {
    final formattedDate = DateFormat('yyyy年MM月dd日').format(date);
    final weekday = _weekdayMap[date.weekday] ?? '';
    return '$formattedDate($weekday)';
  }

  static String mmddE(DateTime date) {
    final formattedDate = DateFormat('MM月dd日').format(date);
    final weekday = _weekdayMap[date.weekday] ?? '';
    return '$formattedDate($weekday)';
  }

  static String ddE(DateTime date) {
    final formattedDate = DateFormat('dd日').format(date);
    final weekday = _weekdayMap[date.weekday] ?? '';
    return '$formattedDate($weekday)';
  }
}
