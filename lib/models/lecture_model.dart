part of 'models.dart';

const List roleList = [
  'admin',
  'lecturer',
  'assistant',
  'student',
];

class LectureModel {
  LectureModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.code,
    required this.color,
    required this.role,
    required this.lecturer,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String desc;
  String code;
  String color;
  String role;
  String lecturer;
  DateTime createdAt;
  DateTime updatedAt;

  factory LectureModel.fromJson(Map<String, dynamic> json) => LectureModel(
        id: json['id'],
        name: json['name'],
        desc: json['desc'],
        code: json['code'],
        color: json['color'],
        role: roleList[json['pivot']['level']] ?? 3,
        lecturer: json['users']['name'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'desc': desc,
        'code': code,
        'color': color,
        'role': role,
        'lecturer': lecturer,
        'created_at': createdAt.toString(),
        'updated_at': updatedAt.toString(),
      };
}
