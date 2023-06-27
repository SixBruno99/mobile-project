// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Note {
  final DateTime date;
  final String text;

  Note({
    required this.date,
    required this.text,
  });

  Note copyWith({
    DateTime? date,
    String? text,
  }) {
    return Note(
      date: date ?? this.date,
      text: text ?? this.text,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  DateTime _selectedDate = DateTime.now();
  List<Note> _notes = [];

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  void _addNote() async {
    final Note? note = await showDialog<Note>(
      context: context,
      builder: (BuildContext context) {
        String text = '';

        return AlertDialog(
          title: Text('Adicionar Nota'),
          content: TextField(
            onChanged: (value) {
              text = value;
            },
            decoration: InputDecoration(
              hintText: 'Digite a nota...',
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    final newNote = Note(
                      date: _selectedDate,
                      text: text,
                    );
                    Navigator.of(context).pop(newNote);
                  },
                  child: Text('Adicionar'),
                ),
              ],
            )
          ],
        );
      },
    );

    if (note != null) {
      setState(() {
        _notes.add(note);
      });
    }
  }

  void _editNote(Note note) async {
    final updatedNote = await showDialog<Note>(
      context: context,
      builder: (BuildContext context) {
        String text = note.text;

        return AlertDialog(
          title: Text('Editar Nota'),
          content: TextField(
            onChanged: (value) {
              text = value;
            },
            decoration: InputDecoration(
              hintText: 'Digite a nota...',
            ),
            controller: TextEditingController(text: note.text),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final editedNote = note.copyWith(text: text);
                Navigator.of(context).pop(editedNote);
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );

    if (updatedNote != null) {
      setState(() {
        final index = _notes.indexOf(note);
        _notes[index] = updatedNote;
      });
    }
  }

  void _deleteNote(Note note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir Nota'),
          content: Text('Tem certeza de que deseja excluir esta nota?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _notes.remove(note);
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Excluir'),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  List<Note> _getNotesByDate(DateTime date) {
    return _notes.where((note) => note.date.isAtSameMomentAs(date)).toList();
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2023, 1, 1),
      lastDay: DateTime.utc(2023, 12, 31),
      focusedDay: DateTime.now(),
      selectedDayPredicate: (DateTime date) {
        return _selectedDate.day == date.day &&
            _selectedDate.month == date.month &&
            _selectedDate.year == date.year;
      },
      onDaySelected: (selectedDate, focusedDate) {
        setState(() {
          _selectedDate = selectedDate;
        });
      },
    );
  }

  Widget _buildNotesList() {
    final notes = _getNotesByDate(_selectedDate);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) {
        final note = notes[index];

        return ListTile(
          title: Text(note.text),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _editNote(note);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteNote(note);
                },
              ),
            ],
          ),
          onTap: () {
            _editNote(note);
          },
          onLongPress: () {
            _deleteNote(note);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de anotações'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildCalendar(),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notas do dia ${_dateFormat.format(_selectedDate)}:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                _buildNotesList(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNote();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}


