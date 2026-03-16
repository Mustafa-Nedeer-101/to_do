import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/data/repositories/notes_repository.dart';
import 'package:to_do/presentation/cubit/notes_state.dart';
import '../../data/models/note.dart';

class NotesCubit extends Cubit<NotesState> {
  final NotesRepository _repository;

  NotesCubit({required NotesRepository repository})
    : _repository = repository,
      super(NotesInitial());

  // Load all notes
  Future<void> loadNotes() async {
    emit(NotesLoading());
    try {
      final notes = _repository.getNotes();
      // Sort by createdAt descending (newest first)
      notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError('Failed to load notes: ${e.toString()}'));
    }
  }

  // Add a new note
  Future<void> addNote(Note note) async {
    try {
      await _repository.addNote(note);
      await loadNotes(); // Refresh the list
    } catch (e) {
      emit(NotesError('Failed to add note: ${e.toString()}'));
    }
  }

  // Update an existing note
  Future<void> updateNote(Note note) async {
    try {
      await _repository.updateNote(note);
      await loadNotes(); // Refresh the list
    } catch (e) {
      emit(NotesError('Failed to update note: ${e.toString()}'));
    }
  }

  // Delete a note
  Future<void> deleteNote(String id) async {
    try {
      await _repository.deleteNote(id);
      await loadNotes(); // Refresh the list
    } catch (e) {
      emit(NotesError('Failed to delete note: ${e.toString()}'));
    }
  }

  // Search notes
  void searchNotes(String query) {
    try {
      if (state is NotesLoaded) {
        final currentState = state as NotesLoaded;
        if (query.isEmpty) {
          emit(NotesLoaded(currentState.notes));
        } else {
          final searchResults = _repository.searchNotes(query);
          emit(NotesLoaded(searchResults));
        }
      } else {
        // If not in loaded state, load notes first then search
        loadNotes().then((_) {
          if (state is NotesLoaded) {
            final results = _repository.searchNotes(query);
            emit(NotesLoaded(results));
          }
        });
      }
    } catch (e) {
      emit(NotesError('Failed to search notes: ${e.toString()}'));
    }
  }

  // Get a single note by ID
  Note? getNoteById(String id) {
    try {
      return _repository.getNoteById(id);
    } catch (e) {
      return null;
    }
  }

  // Delete all notes
  Future<void> deleteAllNotes() async {
    try {
      await _repository.deleteAllNotes();
      await loadNotes(); // Refresh the list (will be empty)
    } catch (e) {
      emit(NotesError('Failed to delete all notes: ${e.toString()}'));
    }
  }
}
