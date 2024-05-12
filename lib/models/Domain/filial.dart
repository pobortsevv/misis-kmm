import 'package:misis/screens/login/list_screen/view_models/list_view_model.dart';

/// Доменная модель филиала
final class Filial extends IdentifiableModel {
  @override
  final int id;
  @override
  final String name;
  final String shortname;
  final String code;

  Filial({
    required this.id,
    required this.name,
    required this.shortname,
    required this.code
  });

  factory Filial.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'shortname': String shortname,
        'code': String code
      } => Filial(id: id, name: name, shortname: shortname, code: code),
      _ => throw const FormatException('Failed to load filial.')
    };
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shortname': shortname,
      'code': code
    };
  }
}