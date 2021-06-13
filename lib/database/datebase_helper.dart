import 'dart:io';
import 'package:path/path.dart';
import 'package:quiz_app/database/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";

  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableName (
                $columnOne TEXT NOT NULL,
                $columnTwo INTEGER NOT NULL,
                $columnThree TEXT NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(NoteModel noteModel) async {
    Database db = await database;
    int id = await db.insert(tableName, noteModel.toMap());
    return id;
  }

  Future<List<NoteModel>> queryNotes() async {
    Database db = await database;
    List<Map> maps = await db.query(tableName, columns: [columnOne, columnTwo, columnThree]);
    if (maps.length > 0) {
      List<NoteModel> notes = [];
      maps.forEach((element) {
        notes.add(NoteModel.fromMap(element));
      });
      return notes;
    }
    return null;
  }
}
