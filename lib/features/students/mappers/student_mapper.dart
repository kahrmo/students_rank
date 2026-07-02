import '../data/models/student_model.dart';
import '../domain/entities/student.dart';

class StudentMapper {
  static StudentModel toModel(Student entity) {
    return StudentModel.fromEntity(entity);
  }

  static Student toEntity(StudentModel model) {
    return Student(
      id: model.id,
      name: model.name,
      nickname: model.nickname,
      course: model.course,
      classYear: model.classYear,
      birthDate: model.birthDate,
      ratings: model.ratings,
      legendLevel: model.legendLevel,
    );
  }
}
