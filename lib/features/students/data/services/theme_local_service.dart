import 'package:sqflite/sqflite.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/result/result.dart';

class ThemeLocalService {
  static const _themeModeKey = 'theme_mode';

  final AppDatabase _appDatabase;

  ThemeLocalService(this._appDatabase);

  Future<Result<bool>> getSavedTheme() async {
    try {
      final database = await _appDatabase.database;

      final rows = await database.query(
        AppDatabase.settingsTable,
        columns: ['setting_value'],
        where: 'setting_key = ?',
        whereArgs: [_themeModeKey],
        limit: 1,
      );

      if (rows.isEmpty) {
        return const Success(false);
      }

      final value = rows.first['setting_value'] as int;
      return Success(value == 1);
    } catch (error, stackTrace) {
      return Failure(
        AppError(
          'Erro ao carregar tema do banco de dados local',
          exception: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<Result<void>> saveTheme(bool isDarkMode) async {
    try {
      final database = await _appDatabase.database;

      await database.insert(AppDatabase.settingsTable, {
        'setting_key': _themeModeKey,
        'setting_value': isDarkMode ? 1 : 0,
      }, conflictAlgorithm: ConflictAlgorithm.replace);

      return const Success(null);
    } catch (error, stackTrace) {
      return Failure(
        AppError(
          'Erro ao salvar tema no banco de dados local',
          exception: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
