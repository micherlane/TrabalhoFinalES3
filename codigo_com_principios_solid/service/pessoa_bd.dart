import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cadastro_pessoa_app/model/pessoa.dart';

import '../interfaces/database_service.dart';

const String databaseName = 'person.db';
const String tableName = 'person';
const String sql =
    "CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR, password VARCHAR);";
const int version = 1;

class PersonDatabaseSqlite implements DatabaseService {
  static final PersonDatabaseSqlite _instance = PersonDatabaseSqlite._internal();
  late Database _database;

  factory PersonDatabaseSqlite() {
    return _instance;
  }

  PersonDatabaseSqlite._internal();

  Future<void> _initializeDatabase() async {
    String path = await _getPathDatabase();

    _database = await openDatabase(path, version: version,
        onCreate: (Database db, int version) async {
      await db.execute(sql);
    });
  }

  Future<String> _getPathDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);
    return path;
  }

  Future<Database> get database async {
    if (_database.isOpen == false) {
      await _initializeDatabase();
    }
    return _database;
  }

  @override
  Future<int> createPerson(String name, String password) async {
    final database = await this.database;
    final dataPerson = {"name": name, "password": password};

    int id = await database.insert(tableName, dataPerson);

    return id;
  }

  @override
  Future<int> update(Person person) async {
    final database = await this.database;
    int identification = await database.rawUpdate(
        'UPDATE $tableName SET name = ?, password = ? WHERE ID = ?',
        [person.name, person.password, person.id]);

    return identification;
  }

  @override
  Future<int> delete(int id) async {
    final database = await this.database;
    int identification = await database.rawDelete(
        'DELETE FROM $tableName WHERE ID = ?',
        [id]);

    return identification;
  }

  @override
  Future<List<Person>> getPersons() async {
    final database = await this.database;
    List<Map> listPersons = await database.rawQuery('SELECT * FROM $tableName');

    return listPersons.map((person) => Person.fromMapObject(person)).toList();
  }
}


// Aqui temos uma implementação concreta da interface databaseService
// Nesta classe concreta, há a lógica para a minupulação dos dados usando
// o sqlite. A classe precisa seguir as diretrizes especificadas na interface.
// Consequentemente, PersonDatabaseSqlite assina o contrato para operar no sistema.