import '../../../../core/result/result.dart';
import '../../domain/repositories/theme_repository.dart';
import '../services/theme_local_service.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalService _localService;

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
