import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

import '../models/client.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'training-app.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print('Creating clients table');

        await database.execute(
          "CREATE TABLE clients (id TEXT PRIMARY KEY, firstName TEXT,"
          "lastName TEXT, gender TEXT, height INT, bodyweight INT)",
        );
      },
    );
  }

  Future<void> insertIntoDatabase(dynamic data, String tableName) async {
    final db = await database;
    await db.insert(
      tableName,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Client>> getClients() async {
    final db = await database;
    final List<Map<String, dynamic>> clientMaps = await db.query('clients');

    return List.generate(clientMaps.length, (i) {
      // return Client.createFromMap(clientMaps[i]);
    });
  }

  Future<void> deleteDataInTable(String tableName) async {
    final db = await database;
    await db.execute("DELETE FROM " + tableName);
  }

  Future<void> deleteTable(String tableName) async {
    final db = await database;
    await db.execute("DROP TABLE " + tableName);
  }
}
