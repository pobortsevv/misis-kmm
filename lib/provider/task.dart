import 'dart:convert';

enum TaskType {
  filials('get_filials'),
  groups('get_groups'),
  rooms('get_rooms'),
  teachers('get_teachers'),
  schedule('get_schedule');

  const TaskType(this.bodyParam);
  final String bodyParam;

  String getEncodedBody() {
    return json.encode({ bodyParam: {} });
  }

  String getEncodedBodyByFilial(int filialId) {
    return json.encode({
      bodyParam: {"filial": filialId}
    });
  }

  String getScheduleEncodedBodyByGroup(int groupId, String startDate, String endDate) {
    return json.encode({
      bodyParam: { "group": groupId, "start_date": startDate, "end_date": endDate }
    });
  }

  String getScheduleEncodedBodyByTeacher(int teacherId, String startDate, String endDate) {
    return json.encode({
      bodyParam: { "teacher": teacherId, "start_date": startDate, "end_date": endDate }
    });
  }
}
