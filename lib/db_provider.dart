import 'package:flutter/foundation.dart';
import 'package:funflutter/database_helper.dart';
import 'package:funflutter/note.dart';

class DbProvider extends ChangeNotifier {
  List<Note> _notes = [];
  late DatabaseHelper _dbHelper;

  void _getAllNotes() async {
    _notes = await _dbHelper.getNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await _dbHelper.insertNote(note);
    _getAllNotes();
  }

  Future<Note> getNoteById(int id) async {
    return await _dbHelper.getNoteById(id);
  }

  void updateNote(Note note) async {
    await _dbHelper.updateNote(note);
    _getAllNotes();
  }

  void deleteNote(int id) async {
    await _dbHelper.deleteNote(id);
    _getAllNotes();
  }

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllNotes();
  }

  List<Note> get notes => _notes;
}
