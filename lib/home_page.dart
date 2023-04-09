import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:notes_app/add_note_full_scree_dialog.dart';
import 'package:notes_app/note_full_screen_dialog.dart';
import 'package:notes_app/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = ""; // state variable to store search query
  late Color _backgroundColor = Colors.white; // Initialize with default color
  late Color _notesColor = Colors.blueGrey;

  Future<void> _refreshNotes() async {
    // Refresh notes here, e.g., by calling an API or performing an async operation
    // You can update the notes data in the provider and call notifyListeners()
    // to rebuild the UI with updated data

    // Example of updating notes data in the provider and calling notifyListeners()
    await Future.delayed(
        const Duration(seconds: 1)); // Example delay for simulation
    setState(() {
      searchQuery = "";
    }); // Call notifyListeners() to rebuild the UI
  }

  @override
  void initState() {
    super.initState();
    _loadBackgroundColor();
    _loadNotesColor();
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

  Future<void> _loadNotesColor() async {
    // Load background color from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int notesColor = prefs.getInt('notes_color') ?? Colors.white.value;
    setState(() {
      _notesColor = Color(notesColor);
    });
  }

  void _updateBackgroundColor(Color color) async {
    setState(() {
      _backgroundColor = color;
    });

    // Store the selected background color in shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('background_color', color.value);
  }

  void _updateNotesColor(Color color) async {
    setState(() {
      _notesColor = color;
    });

    // Store the selected background color in shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('notes_color', color.value);
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Column(
        children: [
          const SizedBox(
            height: 50
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
              icon: const Icon(Icons.color_lens),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Select Background Color'),
                      content: ColorPicker(
                        pickerColor: _backgroundColor,
                        onColorChanged: (color) {
                          _updateBackgroundColor(color);
                        },
                        // ignore: deprecated_member_use
                        showLabel: true,
                        pickerAreaHeightPercent: 0.8,
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        ElevatedButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.note_sharp),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Select Notes Color'),
                      content: ColorPicker(
                        pickerColor: _notesColor,
                        onColorChanged: (color) {
                          _updateNotesColor(color);
                        },
                        // ignore: deprecated_member_use
                        showLabel: true,
                        pickerAreaHeightPercent: 0.8,
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        ElevatedButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ]),
          Container(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: MediaQuery.of(context).padding.top + 16.0,
            ),
            child: TextField(
              onChanged: (value) {
                // Update search query
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshNotes,
              child: ListView.builder(
                itemCount: taskProvider.notes.length,
                itemBuilder: (context, index) {
                  final note = taskProvider.notes[index];
                  String title = note;
                  String subtitle = "";
                  if (note.contains("\n")) {
                    title = note.substring(0, note.indexOf("\n"));
                    //subtitle = note.substring(note.indexOf("\n") + 1);
                  }
                  // Filter notes based on search query
                  if (searchQuery.isNotEmpty &&
                      !title
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase())) {
                    return Container();
                  }
                  return Dismissible(
                    key: Key(note),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      taskProvider.deleteNote(index);
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    },
                    background: Container(
                      color: Colors.red[300],
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(
                        right: 18.0,
                      ),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: _notesColor,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10.0),
                      child: SizedBox(
                        height: 70,
                        child: ListTile(
                          title: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                // Add style for pinned notes
                              ),
                            ),
                          ),
                          subtitle: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              subtitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NoteFullScreenDialog(
                                    note: note, index: index),
                              ),
                            );
                          },
                          trailing: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white38,
                            child: IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.black,
                              onPressed: () {
                                taskProvider.deleteNote(index);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.check),
        splashColor: Colors.green,
        backgroundColor: Colors.black,
        label: const Text(
          "Add",
          style: TextStyle(fontFamily: 'Roboto'),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AddNoteFullScreenDialog();
            },
          );
        },
      ),
    );
  }
}
