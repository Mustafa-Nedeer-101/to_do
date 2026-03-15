import 'package:to_do/data/services/notes_local_service.dart';
import '../models/note.dart';

abstract class NotesRepository {
  List<Note> getNotes();
  Future<void> addNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String id);
  Note? getNoteById(String id);

  // Optional: Add these if you want more features
  List<Note> searchNotes(String query);
  Future<void> deleteAllNotes();
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
      throw Exception('Failed to get notes: $e');
    }
  }

  @override
  Future<void> addNote(Note note) async {
    try {
      // Optional validation
      if (note.title.isEmpty && note.content.isEmpty) {
        throw Exception('Cannot add empty note');
      }
      await _localService.addNote(note);
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  @override
  Future<void> updateNote(Note note) async {
    try {
      // Check if note exists before updating
      final existingNote = getNoteById(note.id);
      if (existingNote == null) {
        throw Exception('Note not found');
      }
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
      final notes = _localService.getNotes();
      return notes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  List<Note> searchNotes(String query) {
    try {
      if (query.isEmpty) return getNotes();

      final notes = getNotes();
      return notes
          .where(
            (note) =>
                note.title.toLowerCase().contains(query.toLowerCase()) ||
                note.content.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> deleteAllNotes() async {
    try {
      final notes = getNotes();
      for (var note in notes) {
        await _localService.deleteNote(note.id);
      }
    } catch (e) {
      throw Exception('Failed to delete all notes: $e');
    }
  }
}
