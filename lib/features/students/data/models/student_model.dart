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

  factory StudentModel.fromMap(Map<String, Object?> map) {
    return StudentModel(
      id: map['id'] as String,
      name: map['name'] as String,
      nickname: map['nickname'] as String? ?? '',
      course: Course.values.firstWhere(
        (c) => c.name == map['course'],
        orElse: () => Course.info,
      ),
      classYear: map['class_year'] as int,
      birthDate: DateTime.parse(map['birth_date'] as String),
      ratings: PopularityRatingsModel.fromMap(map),
      legendLevel: map['legend_level'] as int,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'nickname': nickname,
      'course': course.name,
      'class_year': classYear,
      'birth_date': birthDate.toIso8601String(),
      ...PopularityRatingsModel.fromEntity(ratings).toMap(),
      'legend_level': legendLevel,
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
