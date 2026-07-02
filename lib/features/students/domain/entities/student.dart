import 'course.dart';
import 'popularity_ratings.dart';

class Student {
  final String id;
  final String name;
  final String nickname;
  final Course course;
  final int classYear;
  final DateTime birthDate;
  final PopularityRatings ratings;
  final int legendLevel;

  const Student({
    required this.id,
    required this.name,
    required this.nickname,
    required this.course,
    required this.classYear,
    required this.birthDate,
    required this.ratings,
    required this.legendLevel,
  });

  Student copyWith({
    String? id,
    String? name,
    String? nickname,
    Course? course,
    int? classYear,
    DateTime? birthDate,
    PopularityRatings? ratings,
    int? legendLevel,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      course: course ?? this.course,
      classYear: classYear ?? this.classYear,
      birthDate: birthDate ?? this.birthDate,
      ratings: ratings ?? this.ratings,
      legendLevel: legendLevel ?? this.legendLevel,
    );
  }
}
