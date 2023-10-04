import 'package:noteapp/models/noteDataModel.dart';
import 'package:noteapp/services/databaseManagement.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sqflite/sqflite.dart';

class NotesNotifier extends StateNotifier<AsyncValue<List<NoteDataModel>>> {
  final StateNotifierProviderRef<NotesNotifier, AsyncValue<List<NoteDataModel>>> ref;

  NotesNotifier(this.ref) : super(const AsyncValue.loading()) {
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final databaseAsync = ref.watch(databaseProvider);
    final result = databaseAsync;
    final database = result.value;

    if (database != null) {
      final notes = await database.query('notes');
      state = AsyncValue.data(notes.map((row) => NoteDataModel.fromMap(row)).toList());
    } else {
      state = AsyncValue.error("Initialization error", StackTrace.current);
    }
  }

  Future<void> addNote(NoteDataModel note) async {
    final databaseAsync = ref.watch(databaseProvider);
    final result = databaseAsync;
    final database = result.value;

    if (database != null) {
      final id = await database.insert('notes', note.toMap());
      note = note.copyWith(id: id);

      state.whenData((notes) {
        state = AsyncValue.data([...notes, note]);
      });
    }
  }

  Future<void> updateNote(NoteDataModel note) async {
    final databaseAsync = ref.watch(databaseProvider);
    final result = databaseAsync;
    final database = result.value;

    if (database != null) {
      await database.update(
        'notes',
        note.toMap(),
        where: 'id = ?',
        whereArgs: [note.id],
      );

      state.whenData((notes) {
        final updatedNotes = notes.map((n) => n.id == note.id ? note : n).toList();
        state = AsyncValue.data(updatedNotes);
      });
    }
  }

  Future<void> deleteNote(NoteDataModel note) async {
    final databaseAsync = ref.watch(databaseProvider.future);
    final result = await databaseAsync;
    final database = result;

    await database.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [note.id],
    );

    state.whenData((notes) {
      final updatedNotes = notes.where((n) => n.id != note.id).toList();
      state = AsyncValue.data(updatedNotes);
    });
  }
}

final notesNotifierProvider = StateNotifierProvider<NotesNotifier, AsyncValue<List<NoteDataModel>>>((ref) {
  return NotesNotifier(ref);
});

final getNotesProvider = FutureProvider<List<NoteDataModel>>((ref) {
  final notesState = ref.watch(notesNotifierProvider);
  return notesState.value ?? [];
});
