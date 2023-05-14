import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/noteFields.dart';

late Box<noteFields> notesBox;

class editPage extends StatefulWidget {
  final noteFields pNoteBoxObject;
  final pIndex;
  editPage({required this.pNoteBoxObject, required this.pIndex});

  @override
  State<editPage> createState() => _editPageState();
}

class _editPageState extends State<editPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  String? content;
  final _key = GlobalKey<FormState>();
  DateTime dateRaw = DateTime.now();
  String date = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notesBox = Hive.box('notes');
    titleController.text = widget.pNoteBoxObject.title;
    contentController.text = widget.pNoteBoxObject.content ;

  }

  @override
  Widget build(BuildContext context) {
    date = dateRaw.toString().substring(0, 16);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(onPressed: (){saveData();}, child: Text('Edit',style: TextStyle(color: Colors.white),))
            ],
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(children: [
              Form(
                key: _key,
                child: Column(
                  children: [
                    TextField(
                      style: TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: titleController,

                    ),
                    Text(widget.pNoteBoxObject.date),
                    TextField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: contentController,
                    ),
                  ],
                ),
              ),
            ]),
          )),
    );
  }

  void saveData() {
    final isValid = _key.currentState?.validate();
    if(titleController.text.isEmpty && contentController.text.isEmpty){
      notesBox.deleteAt(widget.pIndex);
      Navigator.pop(context);
    }
    if (isValid != null && isValid) {
      _key.currentState?.save();
      if(titleController.text.isNotEmpty || contentController.text.isNotEmpty ){
        notesBox.putAt(widget.pIndex, noteFields(title: titleController.text, content:  contentController.text, date: date));
        showSuccessMessage('Edited');

      }
      else{
        showErrorMessage('Save failed');
      }
        // showErrorMessage('Edit failed');

    }
  }

  //snackbar
  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
