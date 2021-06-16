import 'package:intl/intl.dart';

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var diffNearestSunday = now.difference(_getNearestSunday());
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = DateFormat('HH:mm a').format(date);
  } else if (diff <= diffNearestSunday) {
    if (date.weekday == 7) {
      time = 'Chủ nhật';
    } else {
      time = 'Thứ ' + (date.weekday + 1).toString();
    }
  } else {
    time =
        DateFormat('d').format(date) + ' tháng ' + DateFormat('M').format(date);
  }
  return time;
}

String readTimestampHHDM(int timestamp) {
  var now = DateTime.now();
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var time = '';
  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = DateFormat('HH:mm').format(date) + ', Hôm nay';
  } else {
    time = DateFormat('HH:mm').format(date) +
        ', ' +
        DateFormat('d/M').format(date);
  }
  return time;
}

DateTime _getNearestSunday() {
  var sunday = 7;
  var now = DateTime.now();
  now.subtract(new Duration(days: 1));
  while (now.weekday != sunday) {
    now = now.subtract(new Duration(days: 1));
  }
  return DateTime(now.year, now.month, now.day);
}
