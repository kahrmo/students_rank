import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/database/app_database.dart';
import 'features/students/data/services/theme_local_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

import 'features/students/data/repositories/student_repository_impl.dart';
import 'features/students/data/repositories/theme_repository_impl.dart';
import 'features/students/data/services/student_local_service.dart';

import 'features/students/domain/facades/student_facade.dart';
import 'features/students/domain/facades/theme_facade.dart';

import 'features/students/domain/usecases/calculate_ranking_usecase.dart';
import 'features/students/domain/usecases/create_student_usecase.dart';
import 'features/students/domain/usecases/delete_student_usecase.dart';
import 'features/students/domain/usecases/get_all_students_usecase.dart';
import 'features/students/domain/usecases/get_saved_theme_usecase.dart';
import 'features/students/domain/usecases/get_student_by_id_usecase.dart';
import 'features/students/domain/usecases/save_theme_usecase.dart';
import 'features/students/domain/usecases/toggle_theme_usecase.dart';
import 'features/students/domain/usecases/update_student_usecase.dart';

import 'features/students/presentation/screens/about_screen.dart';
import 'features/students/presentation/screens/home_screen.dart';
import 'features/students/presentation/screens/ranking_screen.dart';
import 'features/students/presentation/screens/splash_screen.dart';
import 'features/students/presentation/screens/student_details_screen.dart';
import 'features/students/presentation/screens/student_form_screen.dart';
import 'features/students/presentation/screens/students_screen.dart';

import 'features/students/presentation/viewmodels/students_viewmodel.dart';
import 'features/students/presentation/viewmodels/theme_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final appDatabase = AppDatabase();

  final studentLocalService = StudentLocalService(appDatabase);
  final themeLocalService = ThemeLocalService(appDatabase);

  final studentRepo = StudentRepositoryImpl(studentLocalService);
  final themeRepo = ThemeRepositoryImpl(themeLocalService);

  final createStudentUseCase = CreateStudentUseCase(studentRepo);
  final updateStudentUseCase = UpdateStudentUseCase(studentRepo);
  final deleteStudentUseCase = DeleteStudentUseCase(studentRepo);
  final getAllStudentsUseCase = GetAllStudentsUseCase(studentRepo);
  final getStudentByIdUseCase = GetStudentByIdUseCase(studentRepo);
  final calculateRankingUseCase = CalculateRankingUseCase(studentRepo);

  final toggleThemeUseCase = ToggleThemeUseCase(themeRepo);
  final getSavedThemeUseCase = GetSavedThemeUseCase(themeRepo);
  final saveThemeUseCase = SaveThemeUseCase(themeRepo);

  final studentFacade = StudentFacade(
    createStudentUseCase: createStudentUseCase,
    updateStudentUseCase: updateStudentUseCase,
    deleteStudentUseCase: deleteStudentUseCase,
    getAllStudentsUseCase: getAllStudentsUseCase,
    getStudentByIdUseCase: getStudentByIdUseCase,
    calculateRankingUseCase: calculateRankingUseCase,
  );

  final themeFacade = ThemeFacade(
    toggleThemeUseCase: toggleThemeUseCase,
    getSavedThemeUseCase: getSavedThemeUseCase,
    saveThemeUseCase: saveThemeUseCase,
  );

  final studentsViewModel = StudentsViewModel(studentFacade);
  final themeViewModel = ThemeViewModel(themeFacade);

  final router = AppRouter.router(
    splashBuilder: (context) => const SplashScreen(),
    homeBuilder: (context) => HomeScreen(themeViewModel: themeViewModel),
    studentsBuilder: (context) => StudentsScreen(viewModel: studentsViewModel),
    studentFormBuilder: (context, id) =>
        StudentFormScreen(viewModel: studentsViewModel, id: id),
    studentDetailsBuilder: (context, id) =>
        StudentDetailsScreen(viewModel: studentsViewModel, id: id),
    rankingBuilder: (context) => RankingScreen(viewModel: studentsViewModel),
    aboutBuilder: (context) => const AboutScreen(),
  );

  runApp(MainApp(router: router, themeViewModel: themeViewModel));
}

class MainApp extends StatelessWidget {
  final GoRouter router;
  final ThemeViewModel themeViewModel;

  const MainApp({
    super.key,
    required this.router,
    required this.themeViewModel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = themeViewModel.isDarkMode.watch(context);

    return MaterialApp.router(
      title: 'PiramidGame IFPR-Pgua',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
