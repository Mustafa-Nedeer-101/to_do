import 'package:hive_flutter/hive_flutter.dart';
import '../models/note.dart';

class NotesLocalService {
  static const _boxName = 'notes';

  Box get _box => Hive.box(_boxName);

  List<Note> getNotes() {
    return _box.values.map((data) {
      return Note.fromJson(Map<String, dynamic>.from(data));
    }).toList();
  }

  Future<void> addNote(Note note) async {
    await _box.put(note.id, {
      'id': note.id,
      'title': note.title,
      'content': note.content,
      'createdAt': note.createdAt.toIso8601String(),
    });
  }

  Future<void> deleteNote(String id) async {
    await _box.delete(id);
  }

  Future<void> updateNote(Note note) async {
    await addNote(note);
  }
}
