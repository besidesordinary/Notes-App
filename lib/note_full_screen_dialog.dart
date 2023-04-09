import 'package:flutter/material.dart';
import 'package:notes_app/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteFullScreenDialog extends StatefulWidget {
  final String note;
  final int index; // Add index property

  const NoteFullScreenDialog(
      {super.key,
        required this.note,
        required this.index}); // Pass index in the constructor

  @override
  // ignore: library_private_types_in_public_api
  _NoteFullScreenDialogState createState() => _NoteFullScreenDialogState();
}

class _NoteFullScreenDialogState extends State<NoteFullScreenDialog> {
  final TextEditingController _noteController = TextEditingController();
  late Color _backgroundColor = Colors.white; // Initialize with default color

  @override
  void initState() {
    super.initState();
    _noteController.text = widget.note; // Set initial text value to the note
    _loadBackgroundColor();
  }

  void _saveNote() {
    String modifiedNote = _noteController.text;
    Provider.of<TaskProvider>(context, listen: false).updateNote(
        widget.index, modifiedNote); // Call updateNote method from TaskProvider
    Navigator.pop(context);
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
        title: const Text(
          'Note',
          style: TextStyle(fontFamily: 'Roboto'),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.note_add_outlined),
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
                  border: InputBorder.none, // Remove
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
