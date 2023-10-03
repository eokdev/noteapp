import 'package:noteapp/models/noteDataModel.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sqflite/sqflite.dart';


class NotesNotifier extends StateNotifier<List<NoteDataModel>> {
  final Database database;

  NotesNotifier(this.database) : super([]);

  Future<void> loadNotes() async {
    final notes = await database.query('notes');
    state = notes.map((row) => NoteDataModel.fromMap(row)).toList();
  }

  Future<void> addNote(NoteDataModel note) async {
    final id = await database.insert('notes', note.toMap());
    note = note.copyWith(id: id);
    state = [...state, note];
  }

  Future<void> updateNote(NoteDataModel note) async {
    await database.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
    state = state.map((n) => n.id == note.id ? note : n).toList();
  }

  Future<void> deleteNote(NoteDataModel note) async {
    await database.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [note.id],
    );
    state = state.where((n) => n.id != note.id).toList();
  }
}

