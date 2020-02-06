import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';

String buildFilenameDate(String prefix, String suffix) {
  var now = DateTime.now();
  var twoDigits = new NumberFormat("00");
  var month = twoDigits.format(now.month);
  var day = twoDigits.format(now.day);
  return '${prefix}_${now.year}$month${day}_${twoDigits.format(now.hour)}${twoDigits.format(now.minute)}${twoDigits.format(now.second)}$suffix';
}

String buildDateString() {
  var now = DateTime.now();
  var twoDigits = new NumberFormat("00");
  var month = twoDigits.format(now.month);
  var day = twoDigits.format(now.day);
  var hour = twoDigits.format(now.hour);
  var minute = twoDigits.format(now.minute);
  var secs = twoDigits.format(now.second);
  return '${now.year}$month$day$hour$minute$secs';
}

/// Parses a string in the form: YYYYMMDDHHMMSS
DateTime parseDateString(String dateString) {
  RegExp exp = RegExp(r"(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})");
  var itMatches = exp.allMatches(dateString);
  var listMatches = itMatches.toList();
  /*listMatches.forEach( (a) {
    debugPrint('++ ${a.group(1)}');
    debugPrint('** ${a.group(2)}');
  });*/

  var date = DateTime.utc(int.parse(listMatches[0].group(1)),
      int.parse(listMatches[0].group(2)),
      int.parse(listMatches[0].group(3)),
      int.parse(listMatches[0].group(4)),
      int.parse(listMatches[0].group(5)),
      int.parse(listMatches[0].group(6))
  );
  return date;
}

String buildLocalizedDateString(DateTime date, BuildContext context) {
  Locale myLocale = Localizations.localeOf(context);
  var dateFormat = DateFormat.yMMMMd(myLocale.toString());
  //var timeFormat = DateFormat('HH:mm:ss');
  var timeFormat = DateFormat.Hms(myLocale.toString());
  return '${dateFormat.format(date)} - ${timeFormat.format(date)}';
}