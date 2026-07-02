import '../../../../core/result/result.dart';
import '../repositories/theme_repository.dart';

class ToggleThemeUseCase {
  final ThemeRepository _repository;

  ToggleThemeUseCase(this._repository);

  Future<Result<bool>> call() async {
    final currentResult = await _repository.getSavedTheme();
    if (currentResult is Success<bool>) {
      final newMode = !currentResult.data;
      final saveResult = await _repository.saveTheme(newMode);
      if (saveResult is Success) {
        return Success(newMode);
      } else {
        return Failure((saveResult as Failure).error);
      }
    }
    return currentResult;
  }
}
