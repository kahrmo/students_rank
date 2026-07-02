import '../../../../core/result/result.dart';
import '../entities/student.dart';
import '../usecases/create_student_usecase.dart';
import '../usecases/update_student_usecase.dart';
import '../usecases/delete_student_usecase.dart';
import '../usecases/get_all_students_usecase.dart';
import '../usecases/get_student_by_id_usecase.dart';
import '../usecases/calculate_ranking_usecase.dart';

class StudentFacade {
  final CreateStudentUseCase _createStudentUseCase;
  final UpdateStudentUseCase _updateStudentUseCase;
  final DeleteStudentUseCase _deleteStudentUseCase;
  final GetAllStudentsUseCase _getAllStudentsUseCase;
  final GetStudentByIdUseCase _getStudentByIdUseCase;
  final CalculateRankingUseCase _calculateRankingUseCase;

  StudentFacade({
    required CreateStudentUseCase createStudentUseCase,
    required UpdateStudentUseCase updateStudentUseCase,
    required DeleteStudentUseCase deleteStudentUseCase,
    required GetAllStudentsUseCase getAllStudentsUseCase,
    required GetStudentByIdUseCase getStudentByIdUseCase,
    required CalculateRankingUseCase calculateRankingUseCase,
  })  : _createStudentUseCase = createStudentUseCase,
        _updateStudentUseCase = updateStudentUseCase,
        _deleteStudentUseCase = deleteStudentUseCase,
        _getAllStudentsUseCase = getAllStudentsUseCase,
        _getStudentByIdUseCase = getStudentByIdUseCase,
        _calculateRankingUseCase = calculateRankingUseCase;

  Future<Result<Student>> createStudent(Student student) => _createStudentUseCase(student);
  Future<Result<Student>> updateStudent(Student student) => _updateStudentUseCase(student);
  Future<Result<void>> deleteStudent(String id) => _deleteStudentUseCase(id);
  Future<Result<List<Student>>> getAllStudents() => _getAllStudentsUseCase();
  Future<Result<Student>> getStudentById(String id) => _getStudentByIdUseCase(id);
  Future<Result<List<Student>>> calculateRanking() => _calculateRankingUseCase();
}
