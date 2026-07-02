import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/result/result.dart';
import '../models/student_model.dart';

class StudentLocalService {
  final SharedPreferences _prefs;

  StudentLocalService(this._prefs);

  Future<Result<List<StudentModel>>> getAllStudents() async {
    try {
      final jsonString = _prefs.getString('students');
      if (jsonString == null) {
        return const Success([]);
      }
      final List<dynamic> jsonList = json.decode(jsonString);
      final students = jsonList.map((item) => StudentModel.fromJson(item as Map<String, dynamic>)).toList();
      return Success(students);
    } catch (e, stack) {
      return Failure(AppError('Erro ao carregar alunos do armazenamento local', exception: e, stackTrace: stack));
    }
  }

  Future<Result<void>> saveAllStudents(List<StudentModel> students) async {
    try {
      final jsonString = json.encode(students.map((e) => e.toJson()).toList());
      await _prefs.setString('students', jsonString);
      return const Success(null);
    } catch (e, stack) {
      return Failure(AppError('Erro ao salvar alunos no armazenamento local', exception: e, stackTrace: stack));
    }
  }

  Future<Result<bool>> getSavedTheme() async {
    try {
      final isDark = _prefs.getBool('theme_mode') ?? false;
      return Success(isDark);
    } catch (e, stack) {
      return Failure(AppError('Erro ao carregar tema do armazenamento local', exception: e, stackTrace: stack));
    }
  }

  Future<Result<void>> saveTheme(bool isDarkMode) async {
    try {
      await _prefs.setBool('theme_mode', isDarkMode);
      return const Success(null);
    } catch (e, stack) {
      return Failure(AppError('Erro ao salvar tema no armazenamento local', exception: e, stackTrace: stack));
    }
  }
}
