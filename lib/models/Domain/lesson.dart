import 'package:in_date_range/in_date_range.dart';
import 'package:intl/intl.dart';

class Lesson {
  final int id;
  final LessonTime time;
  final String name;
  final String type;
  final String? teacher;
  final String? group;
  final String? room;
  final DateTime date;

  bool get isCurrent {
    final now = DateTime.now();

    final range = DateRange(
      time.makeStartDateTime(date),
      time.makeEndDateTime(date)
    );

    return range.contains(now);
  }

  Lesson({
    required this.id,
    required this.time,
    required this.name,
    required this.type,
    required this.teacher,
    required this.group,
    required this.room,
    required this.date
  });

  static Lesson? fromJson(Map<String, dynamic> header, Map<String, dynamic> json, DateTime date) {
    try {
      final time = LessonTime(start: header['start_lesson'], end: header['end_lesson']);

      for (var value in json.values) {
        if (value is List<dynamic>) {
          final lessons = value;

          if (lessons.isNotEmpty) {
            final object = lessons.first;
            final id = object['subject_id'];
            final name = object['subject_name'];
            final teacher = _getTeacher(object['teachers']);
            final group = _getGroup(object['groups']);
            final room = object['room_name'];
            final type = object['type'];

            return Lesson(
              id: id,
              time: time,
              name: name,
              type: type,
              teacher: teacher,
              group: group,
              room: room,
              date: date
            );
          }
        }
      }
      
      return null;
    } catch(error) {
      throw const FormatException('Failed to load a lesson.');
    }
  }

  // MARK: - Private

  /* 
    Данные методы затирают такие параметры как:
      - id,
      - post,
      - subgroup_id/name
    В итоге мы работает только со строками. В целом это несовсем правильный подход.
    По-хорошему нужно привести teacher, group и room ко одному виду в API.
  */

  static String? _getTeacher(List<dynamic> teachers) {
    if (teachers.isNotEmpty) {
      final teacher = teachers.first;
      
      return teacher['name'];
    }
    return null;
  }

  static String? _getGroup(List<dynamic> groups) {
    if (groups.isNotEmpty) {
      final group = groups.first;

      return group['name'];
    }
    return null;
  }
}

class LessonTime {
  final String start;
  final String end;

  LessonTime({required this.start, required this.end});

  DateTime makeStartDateTime(DateTime day) {
    final timeParts = DateFormat("HH:mm").parse(start);

    return DateTime(day.year, day.month, day.day, timeParts.hour, timeParts.minute)
      .subtract(const Duration(seconds: 1));
  }

  DateTime makeEndDateTime(DateTime day) {
    final timeParts = DateFormat("HH:mm").parse(end);

    return DateTime(day.year, day.month, day.day, timeParts.hour, timeParts.minute)
      .add(const Duration(seconds: 1));
  }
}