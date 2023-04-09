import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider with ChangeNotifier {
  //List<String> tasks = [];
  List<String> notes = [];
  late SharedPreferences _prefs; // Add 'late' keyword

  TaskProvider() {
    _loadData(); // Load data from SharedPreferences when the provider is initialized
  }

  Future<void> _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    //tasks = _prefs.getStringList('tasks') ?? [];
    notes = _prefs.getStringList('notes') ?? [];
    notifyListeners();
  }

  Future<void> _saveData() async {
    //await _prefs.setStringList('tasks', tasks);
    await _prefs.setStringList('notes', notes);
  }

  void addTask(String task) {
    //tasks.add(task);
    notifyListeners();
    _saveData(); // Save data to SharedPreferences after adding a task
  }

  void deleteTask(int index) {
    //tasks.removeAt(index);
    notifyListeners();
    _saveData(); // Save data to SharedPreferences after deleting a task
  }

  void addNote(String note) {
    notes.add(note);
    notifyListeners();
    _saveData(); // Save data to SharedPreferences after adding a note
  }

  void deleteNote(int index) {
    notes.removeAt(index);
    notifyListeners();
    _saveData(); // Save data to SharedPreferences after deleting a note
  }

  void updateNote(int index, String updatedNote) {
    notes[index] = updatedNote;
    notifyListeners();
    _saveData(); // Save data to SharedPreferences after updating a note
  }
}
