import 'package:to_do/data/services/notes_local_service.dart';
import '../models/note.dart';

abstract class NotesRepository {
  List<Note> getNotes();
  Future<void> addNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String id);
  Note? getNoteById(String id);
}

class NotesRepositoryImpl implements NotesRepository {
  final NotesLocalService _localService;

  NotesRepositoryImpl({required NotesLocalService localService})
    : _localService = localService;

  @override
  List<Note> getNotes() {
    try {
      return _localService.getNotes();
    } catch (e) {
      // You can log the error here
      throw Exception('Failed to get notes: $e');
    }
  }

  @override
  Future<void> addNote(Note note) async {
    try {
      await _localService.addNote(note);
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  @override
  Future<void> updateNote(Note note) async {
    try {
      // Your service's updateNote just calls addNote (which overwrites)
      await _localService.updateNote(note);
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    try {
      await _localService.deleteNote(id);
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }

  @override
  Note? getNoteById(String id) {
    try {
      // Since your service doesn't have a direct getById method
      final notes = _localService.getNotes();
      return notes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null; // Return null if note not found
    }
  }
}
