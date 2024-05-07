extension DateTimeExtension on DateTime {
  int get weekNumber {
    DateTime januaryFirst = DateTime(year, 1, 1);

    int differenceInDays = difference(januaryFirst).inDays;

    int weekNumber = (differenceInDays / 7).floor() + 1;

    return weekNumber;
  }

  /// Учитывая европейскую локализацию, первый день недели - Понедельник
  DateTime get firstDayOfTheWeek {
    return subtract(Duration(days: weekday - 1));
  }

  /// Учитывая европейскую локализацию, последний день недели - Воскресенье
  DateTime get lastDayOfTheWeek {
    return add(Duration(days: DateTime.daysPerWeek - weekday));
  }

  DateTime get nextWeek {
    return add(const Duration(days: 7));
  }

  DateTime get previousWeek {
    return subtract(Duration(days: weekday + 1));
  }
}