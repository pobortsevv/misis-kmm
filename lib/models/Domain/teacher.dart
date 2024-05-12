// Пример корнер кейса:
/*
  "id": 114713,
  "first_name": "Кафедры 8",
  "mid_name": null,
  "last_name": "Вакансия 1"
*/

import 'package:misis/screens/login/list_screen/view_models/list_view_model.dart';

/// Доменная модель преподавателя
final class Teacher implements IdentifiableModel {
  @override
  final int id;
  final String firstName;
  final String? midName;
  final String lastName;

  const Teacher({
    required this.id,
    required this.firstName,
    required this.midName,
    required this.lastName
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'first_name': String firstName,
        'mid_name': String? midName,
        'last_name': String lastName
      } => Teacher(id: id, firstName: firstName, midName: midName, lastName: lastName),
      _ => throw const FormatException('Failed to load teacher.')
    };
  }
  
  @override
  String get name => "$lastName $firstName ${midName ?? ""}";
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name
    };
  }
}