import 'package:intl/intl.dart';
import 'package:misis/models/domain/lesson.dart';
import 'package:misis/tools/date_time_extension.dart';

class Schedule {
  final List<Day> upperWeek;
  final List<Day> bottomWeek;

  Schedule({required this.upperWeek, required this.bottomWeek});
}

class Day {
  final String name;
  final String shortName;
  final DateTime date;
  List<Lesson> lessons = List.empty(growable: true);
  bool get isToday => date.isToday;

  Day({
    required this.name,
    required this.shortName,
    required this.date
  });

  factory Day.fromJson(Map<String, dynamic>json) {
    return switch (json) {
      {
        'text': String text,
        'short_text': String shortText,
        'date': String date,
      } => Day(name: text, shortName: shortText, date: DateFormat('dd.MM.yy').parse(date)),
      _ => throw const FormatException('Failed to load a day.')
    };
  }
}
