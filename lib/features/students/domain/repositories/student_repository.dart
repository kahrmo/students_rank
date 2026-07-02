import '../../../../core/result/result.dart';
import '../entities/student.dart';

abstract class StudentRepository {
  Future<Result<List<Student>>> getAllStudents();
  Future<Result<Student>> getStudentById(String id);
  Future<Result<Student>> createStudent(Student student);
  Future<Result<Student>> updateStudent(Student student);
  Future<Result<void>> deleteStudent(String id);
}
