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
    final result = await _localService.getAllStudents();
    if (result is Success<List<StudentModel>>) {
      try {
        final student = result.data.firstWhere((s) => s.id == id);
        return Success(student);
      } catch (e) {
        return const Failure(AppError('Aluno não encontrado com o ID fornecido'));
      }
    } else {
      return Failure((result as Failure).error);
    }
  }

  @override
  Future<Result<Student>> createStudent(Student student) async {
    final result = await _localService.getAllStudents();
    if (result is Success<List<StudentModel>>) {
      final list = List<StudentModel>.from(result.data);
      final studentModel = StudentModel.fromEntity(student);
      list.add(studentModel);
      final saveResult = await _localService.saveAllStudents(list);
      if (saveResult is Success) {
        return Success(studentModel);
      } else {
        return Failure((saveResult as Failure).error);
      }
    } else {
      return Failure((result as Failure).error);
    }
  }

  @override
  Future<Result<Student>> updateStudent(Student student) async {
    final result = await _localService.getAllStudents();
    if (result is Success<List<StudentModel>>) {
      final list = List<StudentModel>.from(result.data);
      final index = list.indexWhere((s) => s.id == student.id);
      if (index == -1) {
        return const Failure(AppError('Aluno não encontrado para atualização'));
      }
      final studentModel = StudentModel.fromEntity(student);
      list[index] = studentModel;
      final saveResult = await _localService.saveAllStudents(list);
      if (saveResult is Success) {
        return Success(studentModel);
      } else {
        return Failure((saveResult as Failure).error);
      }
    } else {
      return Failure((result as Failure).error);
    }
  }

  @override
  Future<Result<void>> deleteStudent(String id) async {
    final result = await _localService.getAllStudents();
    if (result is Success<List<StudentModel>>) {
      final list = List<StudentModel>.from(result.data);
      final index = list.indexWhere((s) => s.id == id);
      if (index == -1) {
        return const Failure(AppError('Aluno não encontrado para exclusão'));
      }
      list.removeAt(index);
      final saveResult = await _localService.saveAllStudents(list);
      if (saveResult is Success) {
        return const Success(null);
      } else {
        return Failure((saveResult as Failure).error);
      }
    } else {
      return Failure((result as Failure).error);
    }
  }
}
