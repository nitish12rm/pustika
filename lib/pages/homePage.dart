import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pustika/pages/addPage.dart';
import 'package:pustika/pages/editPage.dart';

import '../models/noteFields.dart';

class homePage extends StatefulWidget {
  homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late Box<noteFields> notesBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notesBox = Hive.box('notes');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: notesBox.listenable(),
        builder: (context, box, child) {
          return Scaffold(
            //Top Bar

            //Main Area for Note Tiles
            body: Padding(
              padding: EdgeInsets.all(20),
              child: ListView.builder(
                  itemCount: notesBox.length,
                  itemBuilder: (context, index) {
                    int reveresedIndex = notesBox.length - 1 - index;
                    final noteBoxObject =
                        notesBox.getAt(reveresedIndex) as noteFields;
                    return Slidable(

                      endActionPane:
                          ActionPane(motion: StretchMotion(), children: [
                        SlidableAction(
                          backgroundColor: Colors.redAccent,
                          onPressed: (_){
                            deleteData(reveresedIndex);
                          },
                          icon: Icons.delete,
                        ),
                      ],),
                      child: InkWell(
                        child: Container(
                          height: 100,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Text(
                                noteBoxObject.title,
                              ),
                              subtitle: Text(
                                '${noteBoxObject.date.substring(0, 10)}'
                                ' '
                                '${noteBoxObject.content}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => editPage(
                                            pNoteBoxObject: noteBoxObject,
                                            pIndex: reveresedIndex)));
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),

            //Bottom Bar
            floatingActionButton: FloatingActionButton(
              elevation: 5,
              backgroundColor: Colors.white12,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => addPage()));
              },
              child: Icon(
                size: 30,
                Icons.add,
                color: Colors.white,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              notchMargin: 8,
              shape: CircularNotchedRectangle(),
              child: Container(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 45,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('${notesBox.length.toString()} notes'),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void deleteData(int index) {
    notesBox.deleteAt(index);
  }
}
