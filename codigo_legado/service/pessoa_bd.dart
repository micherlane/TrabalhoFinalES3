import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cadastro_pessoa_app/model/pessoa.dart';

const String databaseName = 'person.db';
const String tableName = 'person';
const String sql =
    "CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR, password VARCHAR);";
const int version = 1;

class PersonDatabase {
  Future<String> _getPathDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);
    return path;
  }

  Future<Database> _openDatabase() async {
    String path = await _getPathDatabase();

    final database = await openDatabase(path, version: version,
        onCreate: (Database db, int version) async {
      await db.execute(sql);
    });

    return database;
  }

  Future<void> removeDatabase() async {
    String path = await _getPathDatabase();
    await deleteDatabase(path);
  }

  Future<int> createPerson(String name, String password) async {
    final database = await _openDatabase();
    final dataPerson = {"name": name, "password": password};

    int id = await database.insert(tableName, dataPerson);

    return id;
  }

  Future<int> update(Person person) async {
    final database = await _openDatabase();
    int identification = await database.rawUpdate(
      'UPDATE $tableName SET name = ?, password = ? WHERE ID = ?',
      [person.name, person.password, person.id]
    );

    return identification;
  }

  Future<int> delete(int id) async {
    final database = await _openDatabase();
    int identification = await database.rawDelete(
      'DELETE FROM $tableName WHERE ID = ?',
      [id]
    );

    return identification;
  }

  Future<List<Person>> getPersons() async {
    final database = await _openDatabase();
    List<Map> listPersons = await database.rawQuery('SELECT * FROM $tableName');

    return listPersons.map((person) => Person.fromMapObject(person)).toList();
  }
}
