import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/noteFields.dart';
int index=0;
late Box<noteFields> notesBox;

class addPage extends StatefulWidget {

  addPage();

  @override
  State<addPage> createState() => _addPageState();
}

class _addPageState extends State<addPage> {
  String? title;
  String? content;
  final _key = GlobalKey<FormState>();
  DateTime dateRaw = DateTime.now();
  String date = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notesBox = Hive.box('notes');

  }

  @override
  Widget build(BuildContext context) {
    date = dateRaw.toString().substring(0, 16);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
             TextButton(onPressed: (){saveData();}, child: Text('Save',style: TextStyle(color: Colors.white),))
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
                    TextFormField(
                      style: TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onSaved: (value) {
                        title = value.toString();
                      },
                    ),
                    Text(date),
                    TextFormField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onSaved: (value) {
                        content = value.toString();
                      },
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
    if (isValid != null && isValid) {
      _key.currentState?.save();
      if(title!.isNotEmpty || content!.isNotEmpty ) {
        notesBox.add(noteFields(
            title: title.toString(), content: content.toString(), date: date));
        showSuccessMessage('Saved');
        log('Saved');
        log(title.toString());

      }
      else{
        log('Save Failed');
        showErrorMessage('Save failed');

      }

    }
  }
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
