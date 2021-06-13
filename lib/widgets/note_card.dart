import 'package:flutter/material.dart';
import 'package:quiz_app/database/note_model.dart';

class NoteCard extends StatelessWidget {
  final NoteModel noteModel;

  NoteCard({this.noteModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text('${noteModel.position} sec',style: TextStyle(fontSize: 16,color: Colors.lightBlue),),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  '${noteModel.noteDesc}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                )),
          )
        ],
      ),
    );
  }
}
