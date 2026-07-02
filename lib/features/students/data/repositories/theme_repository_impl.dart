import '../../../../core/result/result.dart';
import '../../domain/repositories/theme_repository.dart';
import '../services/student_local_service.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final StudentLocalService _localService;

  ThemeRepositoryImpl(this._localService);

  @override
  Future<Result<bool>> getSavedTheme() async {
    return await _localService.getSavedTheme();
  }

  @override
  Future<Result<void>> saveTheme(bool isDarkMode) async {
    return await _localService.saveTheme(isDarkMode);
  }
}
