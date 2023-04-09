import 'package:flutter/material.dart';
import 'package:notes_app/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNoteFullScreenDialog extends StatefulWidget {
  const AddNoteFullScreenDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddNoteFullScreenDialogState createState() =>
      _AddNoteFullScreenDialogState();
}

class _AddNoteFullScreenDialogState extends State<AddNoteFullScreenDialog> {
  final TextEditingController _noteController = TextEditingController();
  late Color _backgroundColor = Colors.white;

  void _saveNote() {
    String note = _noteController.text;
    Provider.of<TaskProvider>(context, listen: false)
        .addNote(note); // Call addNote method from TaskProvider to add new note
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _loadBackgroundColor();
  }

  Future<void> _loadBackgroundColor() async {
    // Load background color from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int backgroundColor =
        prefs.getInt('background_color') ?? Colors.white.value;
    setState(() {
      _backgroundColor = Color(backgroundColor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Add Note'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.note_add_rounded),
            onPressed:
            _saveNote, // Call the _saveNote method when save button is pressed
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextField(
                controller: _noteController,
                readOnly: false, // Set read-only property to false
                maxLines: null, // Allow multiple lines
                decoration: const InputDecoration(
                  border: InputBorder.none, // Remove border
                  hintText: 'Enter your note',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
