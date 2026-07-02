import '../../../../core/result/result.dart';
import '../repositories/student_repository.dart';

class DeleteStudentUseCase {
  final StudentRepository _repository;

  DeleteStudentUseCase(this._repository);

  Future<Result<void>> call(String id) async {
    return await _repository.deleteStudent(id);
  }
}
