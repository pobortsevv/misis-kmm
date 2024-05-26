import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:misis/models/domain/schedule.dart';
import 'package:misis/models/domain/user.dart';

import 'package:misis/models/dto/filial_dto.dart';
import 'package:misis/models/dto/group_dto.dart';
import 'package:misis/models/dto/room_dto.dart';
import 'package:misis/models/dto/schedule_models/get_schedule.dart';
import 'package:misis/models/dto/teacher_dto.dart';

import 'package:misis/models/domain/filial.dart';
import 'package:misis/models/domain/group.dart';
import 'package:misis/models/domain/room.dart';
import 'package:misis/models/domain/teacher.dart';

import 'package:misis/provider/app_url.dart';
import 'package:misis/provider/task.dart';
import 'package:misis/tools/date_time_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppProvider {
  Future<List<Filial>> fetchFilials();
  Future<List<Group>> fetchGroups(int filialId);
  Future<List<Room>> fetchRooms(int filialId);
  Future<List<Teacher>> fetchTeachers(int filialId);
  Future<List<Day>> fetchWeekSchedule(int id, Status status, DateTime date);
}

final class AppProviderImp implements AppProvider {
  final DateFormat _dateFormatter = DateFormat("yyyy-MM-dd");
  
  @override
  Future<List<Filial>> fetchFilials() async {
    final body = TaskType.filials.getEncodedBody();
    final response = await _makeResponse(body);

    if (response.statusCode == 200) {
      final getFilials = GetFilials.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

      return getFilials.asDomainModel();
    } else {
      throw Exception('Failed to load filials');
    }
  }

  @override
  Future<List<Group>> fetchGroups(int filialId) async {
    final body = TaskType.groups.getEncodedBodyByFilial(filialId);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final cachedGroups = prefs.getString('groups_$filialId');
    if (cachedGroups != null) {
      final getGroups = GetGroups.fromJson(jsonDecode(cachedGroups) as Map<String, dynamic>);

      return getGroups.asDomainModel(); 
    }

    final response = await _makeResponse(body);

    if (response.statusCode == 200) {
      final getGroups = GetGroups.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      prefs.setString('groups_$filialId', response.body);

      return getGroups.asDomainModel();
    } else {
      throw Exception('Failed to load groups');
    }
  }

  @override
  Future<List<Room>> fetchRooms(int filialId) async {
    final body = TaskType.rooms.getEncodedBodyByFilial(filialId);
    final response = await _makeResponse(body);

    if (response.statusCode == 200) {
      final getRooms = GetRooms.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

      return getRooms.asDomainModel();
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  @override
  Future<List<Teacher>> fetchTeachers(int filialId) async {
    final body = TaskType.teachers.getEncodedBodyByFilial(filialId);
    final response = await _makeResponse(body);

    if (response.statusCode == 200) {
      final getTeachers = GetTeachers.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

      return getTeachers.asDomainModel();
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  @override
  Future<List<Day>> fetchWeekSchedule(int id, Status status, DateTime date) async {
    final startDate = _dateFormatter.format(date.firstDayOfTheWeek);
    final endDate = _dateFormatter.format(date.lastDayOfTheWeek);
    final String body;
    switch (status) {
      case Status.student: body = TaskType.schedule.getScheduleEncodedBodyByGroup(id, startDate, endDate);
      case Status.teacher: body = TaskType.schedule.getScheduleEncodedBodyByTeacher(id, startDate, endDate);
    }
    final week = await _fetchWeek(body);

    return week.isEmpty ? _makeEmptyWeek(date) : week + [_sunday(date)];
  }

  Future<List<Day>> _fetchWeek(String body) async {
    final response = await _makeResponse(body);

    if (response.statusCode == 200) {
      final dto = GetScheduleSimplifyDTO.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

      return dto != null ? dto.asDomain() : [];
    } else {
      throw Exception('Failed to load schedule');
    }
  }

  // MARK: Private

  static Future<http.Response> _makeResponse(String body) {
    return http.put(Uri.parse(AppUrl.requestURL), headers: _additionalHeaders, body: body);
  }

  static final Map<String, String> _additionalHeaders = {
    "Accept": "application/json",
    "Content-type": "application/json",
  };

  static Day _sunday(DateTime date) {
    return Day(name: "воскресенье ", shortName: "Вс", date: date.lastDayOfTheWeek);
  }

  static List<Day> _makeEmptyWeek(DateTime date) {
    final firstDayOfTheWeek = date.firstDayOfTheWeek;

    return [
      Day(name: "понедельник ", shortName: "Пн", date: firstDayOfTheWeek),
      Day(name: "вторник ", shortName: "Вт", date: firstDayOfTheWeek.add(const Duration(days: 1))),
      Day(name: "среда ", shortName: "Ср", date: firstDayOfTheWeek.add(const Duration(days: 2))),
      Day(name: "четверг ", shortName: "Чт", date: firstDayOfTheWeek.add(const Duration(days: 3))),
      Day(name: "пятница ", shortName: "Пт", date: firstDayOfTheWeek.add(const Duration(days: 4))),
      Day(name: "суббота ", shortName: "Сб", date: firstDayOfTheWeek.add(const Duration(days: 5))),
      _sunday(date)
    ];
  }
}
