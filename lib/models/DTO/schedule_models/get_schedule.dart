import 'package:misis/models/domain/schedule.dart';

/// Родительский слой модели. Маппинг при ответе вида:
/*
  "get_schedule": {
    ...
  }
*/
class GetSchedule {
  final Map<String, dynamic> object;

  const GetSchedule({required this.object});

  factory GetSchedule.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'get_schedule': Map<String, dynamic> object
      } => GetSchedule(object: object),
      _ => throw const FormatException('Failed to load get_schedule.')
    };
  }
}

/// Упрощенная модель, с необходимыми полями get_schedule
/*
  "get_schedule": {
    "status": "FOUND",
    "schedule_header": { ... },
    "schedule": { ... }
  }
*/

class GetScheduleSimplifyDTO {
  final String status; // Сделать проверку на уровне провайдера. Если found => asDomain()
  final ScheduleHeaderDTO header;
  final Map<String, dynamic> rawLessons;

  const GetScheduleSimplifyDTO({
    required this.status,
    required this.header,
    required this.rawLessons
  });

  factory GetScheduleSimplifyDTO.fromJson(Map<String, dynamic> json) {
    final getSchedule = GetSchedule.fromJson(json);
    
    try {
      final String status = getSchedule.object['status']; // подумать когда проверять
      final header = ScheduleHeaderDTO.fromJson(getSchedule.object['schedule_header']);
      final Map<String, dynamic> rawLessons = getSchedule.object['schedule'];
      rawLessons.remove('order');

      return GetScheduleSimplifyDTO(status: status, header: header, rawLessons: rawLessons);
    } catch(error) {
      throw const FormatException('Failed to load get_schedule simplify model.');
    }
  }

  List<Day> asDomain() {
    try {
      var days = header.days;

      for (var value in rawLessons.values) {
        if (value is Map<String, dynamic>) {
          final header = value['header'];
          value.remove('header');

          value.forEach((key, value) {
            if (value is Map<String, dynamic>) {
              final lesson = Lesson.fromJson(header, value);

              if (lesson != null) days[key]?.lessons.add(lesson);
            }
          });
        }
      }
      final list = days.entries.map((entry) => entry.value).toList();
      return list;
    } catch(error) {
      throw const FormatException('Failed to map GetScheduleSimplifyDTO as domain');
    }
  }
}

/// Модель "шапки" расписания. По сути это модель дней недели.
/// "header": { ... } игнорируем
/*
  "schedule_header": {
    "col_1": { ... },
    "col_2": { ... },
    "col_3": { ... },
    ...
  }
*/
class ScheduleHeaderDTO {
  final Map<String, Day> days;

  const ScheduleHeaderDTO({required this.days});

  factory ScheduleHeaderDTO.fromJson(Map<String, dynamic> json) {
    Map<String, Day> days = {};
    json.remove('header');

    try {
      json.forEach((key, value) {
        days[key] = Day.fromJson(value);
      });

      return ScheduleHeaderDTO(days: days);
    } catch (error) {
      throw const FormatException('Failed to map ScheduleHeaderDTO model.');
    }
  }
}