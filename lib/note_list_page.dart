import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:funflutter/db_provider.dart';
import 'package:funflutter/note_add_update_page.dart';
import 'package:provider/provider.dart';

class NoteListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Consumer<DbProvider>(
        builder: (context, provider, child) {
          final notes = provider.notes;

          return notes.isEmpty
              ? Center(
                  child: Text(
                    'No notes has been added.\nAdd one now!',
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return Dismissible(
                      key: Key(note.id.toString()),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        // TODO : Kode untuk menghapus note
                        print("direction: $direction");
                        provider.deleteNote(note.id!);
                        Fluttertoast.showToast(
                          msg: "Deleted successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(note.title),
                          subtitle: Text(note.description),
                          onTap: () async {
                            // TODO : Kode untuk mendapatkan note yang dipilih dan dikirimkan ke NoteAddUpdatePage
                            final selectedNote =
                                await provider.getNoteById(note.id!);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return NoteAddUpdatePage(selectedNote);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoteAddUpdatePage()));
        },
      ),
    );
  }
}
