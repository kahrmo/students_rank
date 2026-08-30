import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static const databaseName = 'popu_ranking.db';
  static const databaseVersion = 1;

  static const studentsTable = 'students';
  static const settingsTable = 'app_settings';

  Future<Database>? _databaseFuture;

  Future<Database> get database => _databaseFuture ??= _openDatabase();

  Future<Database> _openDatabase() async {
    final databasesPath = await getDatabasesPath();
    final databasePath = path.join(databasesPath, databaseName);

    return openDatabase(
      databasePath,
      version: databaseVersion,
      onCreate: _createSchema,
    );
  }

  Future<void> _createSchema(Database database, int version) async {
    await database.execute('''
      CREATE TABLE $studentsTable (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        nickname TEXT NOT NULL DEFAULT '',
        course TEXT NOT NULL,
        class_year INTEGER NOT NULL,
        birth_date TEXT NOT NULL,
        resenha INTEGER NOT NULL,
        presenca_vip INTEGER NOT NULL,
        aura INTEGER NOT NULL,
        modo_parceiro INTEGER NOT NULL,
        carisma_natural INTEGER NOT NULL,
        humor_de_milhoes INTEGER NOT NULL,
        energia_de_grupo INTEGER NOT NULL,
        criatividade_caotica INTEGER NOT NULL,
        modo_atleta INTEGER NOT NULL,
        talento_de_palco INTEGER NOT NULL,
        drip_escolar INTEGER NOT NULL,
        coracao_de_dorama INTEGER NOT NULL,
        queridinho_dos_professores INTEGER NOT NULL,
        cerebro_turbo INTEGER NOT NULL,
        caos_controlado INTEGER NOT NULL,
        legend_level INTEGER NOT NULL
      )
    ''');

    await database.execute('''
      CREATE TABLE $settingsTable (
        setting_key TEXT PRIMARY KEY,
        setting_value INTEGER NOT NULL
      )
    ''');
  }
}