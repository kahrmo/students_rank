import '../../domain/entities/course.dart';
import '../../domain/entities/student.dart';
import 'popularity_ratings_model.dart';

class StudentModel extends Student {
  const StudentModel({
    required super.id,
    required super.name,
    required super.nickname,
    required super.course,
    required super.classYear,
    required super.birthDate,
    required super.ratings,
    required super.legendLevel,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nickname: json['nickname'] as String? ?? '',
      course: Course.values.firstWhere(
        (c) => c.name == json['course'],
        orElse: () => Course.info,
      ),
      classYear: json['classYear'] as int,
      birthDate: DateTime.parse(json['birthDate'] as String),
      ratings: PopularityRatingsModel.fromJson(json['ratings'] as Map<String, dynamic>),
      legendLevel: json['legendLevel'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nickname': nickname,
      'course': course.name,
      'classYear': classYear,
      'birthDate': birthDate.toIso8601String(),
      'ratings': PopularityRatingsModel.fromEntity(ratings).toJson(),
      'legendLevel': legendLevel,
    };
  }

  factory StudentModel.fromEntity(Student entity) {
    return StudentModel(
      id: entity.id,
      name: entity.name,
      nickname: entity.nickname,
      course: entity.course,
      classYear: entity.classYear,
      birthDate: entity.birthDate,
      ratings: entity.ratings,
      legendLevel: entity.legendLevel,
    );
  }
}
