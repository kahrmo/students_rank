import '../../../../core/result/result.dart';

abstract class ThemeRepository {
  Future<Result<bool>> getSavedTheme();
  Future<Result<void>> saveTheme(bool isDarkMode);
}
