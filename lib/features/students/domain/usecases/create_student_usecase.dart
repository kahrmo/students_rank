import '../../../../core/result/result.dart';
import '../entities/student.dart';
import '../repositories/student_repository.dart';

class CreateStudentUseCase {
  final StudentRepository _repository;

  CreateStudentUseCase(this._repository);

  Future<Result<Student>> call(Student student) async {
    final computedStudent = student.copyWith(
      legendLevel: student.ratings.totalScore,
    );
    return await _repository.createStudent(computedStudent);
  }
}
