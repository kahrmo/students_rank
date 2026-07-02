import 'package:signals_flutter/signals_flutter.dart';
import '../../../../core/command/command.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/student.dart';
import '../../domain/facades/student_facade.dart';

class StudentsViewModel {
  final StudentFacade _facade;

  final students = signal<List<Student>>([]);
  final isLoading = signal<bool>(false);
  final error = signal<String?>(null);

  StudentsViewModel(this._facade) {
    loadStudents();
  }

  late final loadStudentsCommand = CommandNoParams<List<Student>>(() async {
    isLoading.value = true;
    error.value = null;
    final res = await _facade.getAllStudents();
    isLoading.value = false;
    if (res is Success<List<Student>>) {
      students.value = res.data;
    } else if (res is Failure<List<Student>>) {
      error.value = res.error.message;
    }
    return res;
  });

  late final createStudentCommand = Command<Student, Student>((student) async {
    isLoading.value = true;
    error.value = null;
    final res = await _facade.createStudent(student);
    isLoading.value = false;
    if (res is Success<Student>) {
      await loadStudents();
    } else if (res is Failure<Student>) {
      error.value = res.error.message;
    }
    return res;
  });

  late final updateStudentCommand = Command<Student, Student>((student) async {
    isLoading.value = true;
    error.value = null;
    final res = await _facade.updateStudent(student);
    isLoading.value = false;
    if (res is Success<Student>) {
      await loadStudents();
    } else if (res is Failure<Student>) {
      error.value = res.error.message;
    }
    return res;
  });

  late final deleteStudentCommand = Command<void, String>((id) async {
    isLoading.value = true;
    error.value = null;
    final res = await _facade.deleteStudent(id);
    isLoading.value = false;
    if (res is Success<void>) {
      await loadStudents();
    } else if (res is Failure<void>) {
      error.value = res.error.message;
    }
    return res;
  });

  Future<Result<List<Student>>> loadStudents() => loadStudentsCommand.execute();
  Future<Result<Student>> createStudent(Student student) => createStudentCommand.execute(student);
  Future<Result<Student>> updateStudent(Student student) => updateStudentCommand.execute(student);
  Future<Result<void>> deleteStudent(String id) => deleteStudentCommand.execute(id);

  late final ranking = computed(() {
    final list = List<Student>.from(students.value);
    list.sort((a, b) {
      final cmp = b.legendLevel.compareTo(a.legendLevel);
      if (cmp != 0) return cmp;
      return a.name.compareTo(b.name);
    });
    return list;
  });
}
