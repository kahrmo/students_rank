import 'package:sqflite/sqflite.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/result/result.dart';
import '../models/student_model.dart';

class StudentLocalService {
  final AppDatabase _appDatabase;
  StudentLocalService(this._appDatabase);

  //Listar Geral
  Future<Result<List<StudentModel>>> getAllStudents() async {
    try {
      final database = await _appDatabase.database;

      final rows = await database.query(
        AppDatabase.studentsTable,
        orderBy: 'rowid ASC',
      );

      final students = rows.map(StudentModel.fromMap).toList();
      return Success(students);
    } catch (error, stackTrace) {
      return Failure(
        AppError(
          'Erro ao carregar alunos do banco de dados local',
          exception: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  // Buscar por id
  Future<Result<StudentModel>> getStudentById(String id) async {
    try {
      final database = await _appDatabase.database;

      final rows = await database.query(
        AppDatabase.studentsTable,
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (rows.isEmpty) {
        return const Failure(
          AppError('Aluno não encontrado com o ID fornecido'),
        );
      }

      return Success(StudentModel.fromMap(rows.first));
    } catch (error, stackTrace) {
      return Failure(
        AppError(
          'Erro ao carregar aluno do banco de dados local',
          exception: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  // Criação
  Future<Result<StudentModel>> createStudent(StudentModel student) async {
    try {
      final database = await _appDatabase.database;

      await database.insert(
        AppDatabase.studentsTable,
        student.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      );

      return Success(student);
    } catch (error, stackTrace) {
      print('ERRO REAL AO CADASTRAR ALUNO: $error');
      print(stackTrace);

      return Failure(
        AppError(
          'Erro ao cadastrar aluno no banco de dados local',
          exception: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<Result<StudentModel>> updateStudent(StudentModel student) async {
    try {
      final database = await _appDatabase.database;

      final affectedRows = await database.update(
        AppDatabase.studentsTable,
        student.toMap(),
        where: 'id = ?',
        whereArgs: [student.id],
      );

      if (affectedRows == 0) {
        return const Failure(AppError('Aluno não encontrado para atualização'));
      }

      return Success(student);
    } catch (error, stackTrace) {
      return Failure(
        AppError(
          'Erro ao atualizar aluno no banco de dados local',
          exception: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<Result<void>> deleteStudent(String id) async {
    try {
      final database = await _appDatabase.database;

      final affectedRows = await database.delete(
        AppDatabase.studentsTable,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (affectedRows == 0) {
        return const Failure(AppError('Aluno não encontrado para exclusão'));
      }

      return const Success(null);
    } catch (error, stackTrace) {
      return Failure(
        AppError(
          'Erro ao excluir aluno do banco de dados local',
          exception: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
