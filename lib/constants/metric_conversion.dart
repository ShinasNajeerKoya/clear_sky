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

class CurrentTimeConversion {
  static String formatSecondsToReadableTime(int seconds) {
    Duration duration = Duration(seconds: seconds);
    DateTime dateTime = DateTime(0).add(duration);
    return DateFormat('hh:mm').format(dateTime.toUtc());
  }
}
