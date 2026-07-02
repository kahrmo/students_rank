import '../../../../core/result/result.dart';
import '../repositories/theme_repository.dart';

class GetSavedThemeUseCase {
  final ThemeRepository _repository;

  GetSavedThemeUseCase(this._repository);

  Future<Result<bool>> call() async {
    return await _repository.getSavedTheme();
  }
}
