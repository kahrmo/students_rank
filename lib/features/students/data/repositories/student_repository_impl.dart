import '../../../../core/result/result.dart';
import '../../domain/entities/student.dart';
import '../../domain/repositories/student_repository.dart';
import '../models/student_model.dart';
import '../services/student_local_service.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentLocalService _localService;

  StudentRepositoryImpl(this._localService);

  @override
  Future<Result<List<Student>>> getAllStudents() async {
    final result = await _localService.getAllStudents();
    if (result is Success<List<StudentModel>>) {
      return Success(result.data);
    } else {
      return Failure((result as Failure).error);
    }
  }

  @override
  Future<Result<Student>> getStudentById(String id) async {
    final result = await _localService.getStudentById(id);

    if (result is Success<StudentModel>) {
      return Success(result.data);
    }

    return Failure((result as Failure).error);
  }

  @override
  Future<Result<Student>> createStudent(Student student) async {
    final result = await _localService.createStudent(
      StudentModel.fromEntity(student),
    );

    if (result is Success<StudentModel>) {
      return Success(result.data);
    }

    return Failure((result as Failure).error);
  }

  @override
  Future<Result<Student>> updateStudent(Student student) async {
    final result = await _localService.updateStudent(
      StudentModel.fromEntity(student),
    );

    if (result is Success<StudentModel>) {
      return Success(result.data);
    }

    return Failure((result as Failure).error);
  }

  @override
  Future<Result<void>> deleteStudent(String id) async {
    return _localService.deleteStudent(id);
  }
}
