import 'package:signals_flutter/signals_flutter.dart';
import '../../../../core/command/command.dart';
import '../../../../core/result/result.dart';
import '../../domain/facades/theme_facade.dart';

class ThemeViewModel {
  final ThemeFacade _facade;

  final isDarkMode = signal<bool>(false);

  ThemeViewModel(this._facade) {
    loadTheme();
  }

  late final loadThemeCommand = CommandNoParams<bool>(() async {
    final res = await _facade.getSavedTheme();
    if (res is Success<bool>) {
      isDarkMode.value = res.data;
    }
    return res;
  });

  late final toggleThemeCommand = CommandNoParams<bool>(() async {
    final res = await _facade.toggleTheme();
    if (res is Success<bool>) {
      isDarkMode.value = res.data;
    }
    return res;
  });

  Future<Result<bool>> loadTheme() => loadThemeCommand.execute();
  Future<Result<bool>> toggleTheme() => toggleThemeCommand.execute();
}
