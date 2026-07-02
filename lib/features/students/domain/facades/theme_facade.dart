import '../../../../core/result/result.dart';
import '../usecases/toggle_theme_usecase.dart';
import '../usecases/get_saved_theme_usecase.dart';
import '../usecases/save_theme_usecase.dart';

class ThemeFacade {
  final ToggleThemeUseCase _toggleThemeUseCase;
  final GetSavedThemeUseCase _getSavedThemeUseCase;
  final SaveThemeUseCase _saveThemeUseCase;

  ThemeFacade({
    required ToggleThemeUseCase toggleThemeUseCase,
    required GetSavedThemeUseCase getSavedThemeUseCase,
    required SaveThemeUseCase saveThemeUseCase,
  })  : _toggleThemeUseCase = toggleThemeUseCase,
        _getSavedThemeUseCase = getSavedThemeUseCase,
        _saveThemeUseCase = saveThemeUseCase;

  Future<Result<bool>> toggleTheme() => _toggleThemeUseCase();
  Future<Result<bool>> getSavedTheme() => _getSavedThemeUseCase();
  Future<Result<void>> saveTheme(bool isDarkMode) => _saveThemeUseCase(isDarkMode);
}
