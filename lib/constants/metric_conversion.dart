import 'package:intl/intl.dart';

class SunRiseToSetTimeConversion {
  static String formatUnixTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('hh:mm a').format(dateTime);
  }
}

class DateTimeConversion {
  static String formatUnixTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('EEE, d MMMM yyyy').format(dateTime);
  }
}
