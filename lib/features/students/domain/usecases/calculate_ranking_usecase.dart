import '../../../../core/result/result.dart';
import '../entities/student.dart';
import '../repositories/student_repository.dart';

class CalculateRankingUseCase {
  final StudentRepository _repository;

  CalculateRankingUseCase(this._repository);

  Future<Result<List<Student>>> call() async {
    final result = await _repository.getAllStudents();
    if (result is Success<List<Student>>) {
      final list = List<Student>.from(result.data);
      list.sort((a, b) {
        final cmp = b.legendLevel.compareTo(a.legendLevel);
        if (cmp != 0) return cmp;
        return a.name.compareTo(b.name);
      });
      return Success(list);
    }
    return result;
  }
}
