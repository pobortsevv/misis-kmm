import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:misis/models/domain/schedule.dart';

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

abstract class AppProvider {
  Future<List<Filial>> fetchFilials();
  Future<List<Group>> fetchGroups(int filialId);
  Future<List<Room>> fetchRooms(int filialId);
  Future<List<Teacher>> fetchTeachers(int filialId);
  Future<Schedule> fetchGroupSchedule(int groupId, String startDate, String endDate);
  // Future<Schedule> fetchTeacherSchedule();
}

final class AppProviderImp implements AppProvider {
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
    final response = await _makeResponse(body);

    if (response.statusCode == 200) {
      final getGroups = GetGroups.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

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

  // TODO: сделать запрос на две недели - верхнюю и нижнюю неделю.
  @override
  Future<Schedule> fetchGroupSchedule(int groupId, String startDate, String endDate) async {
    // (6887, "2024-03-18", "2024-03-23");
    final body = TaskType.schedule.getScheduleEncodedBodyByGroup(groupId, startDate, endDate);
    final week = await _fetchWeek(body);

    return Schedule(upperWeek: week, bottomWeek: []);
  }

  Future<List<Day>> _fetchWeek(String body) async {
    final response = await _makeResponse(body);

    if (response.statusCode == 200) {
      final dto = GetScheduleSimplifyDTO.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

      return dto.asDomain();
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
}
