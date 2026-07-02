import '../../../../core/result/result.dart';
import '../entities/student.dart';
import '../repositories/student_repository.dart';

class UpdateStudentUseCase {
  final StudentRepository _repository;

  UpdateStudentUseCase(this._repository);

  Future<Result<Student>> call(Student student) async {
    final computedStudent = student.copyWith(
      legendLevel: student.ratings.totalScore,
    );
    return await _repository.updateStudent(computedStudent);
  }
}
