import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final databaseProvider = FutureProvider<Database>((ref) async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  final path = join(documentsDirectory.path, 'notes_database.db');

  final database = await openDatabase(path, version: 1, onCreate: (db, version) {
    db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        colors INTEGER,
        title TEXT,
        content TEXT,
        body TEXT,  
        category TEXT, 
        creationDate INTEGER,
        modifiedDate INTEGER
      )
    ''');
  });

  return database;
});