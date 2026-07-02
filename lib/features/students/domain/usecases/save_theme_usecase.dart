import '../../../../core/result/result.dart';
import '../repositories/theme_repository.dart';

class SaveThemeUseCase {
  final ThemeRepository _repository;

  SaveThemeUseCase(this._repository);

  Future<Result<void>> call(bool isDarkMode) async {
    return await _repository.saveTheme(isDarkMode);
  }
}
