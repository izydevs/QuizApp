import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/note_bloc.dart';
import 'package:quiz_app/bloc/quiz_bloc.dart';
import 'package:quiz_app/database/note_model.dart';
import 'package:quiz_app/utils/strings.dart';
import 'package:quiz_app/widgets/note_card.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController _controller;
  VoidCallback listener;
  TextEditingController noteDescController = TextEditingController();
  final noteBloc = NoteBloc();
  Map<int, bool> noteSeen = {};

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(videoUrl);

    listener = () {
      if (_controller.value.isInitialized) {
        Duration duration = _controller.value.duration;
        Duration position = _controller.value.position;
        print('duration ${duration.inMilliseconds}');
        print('position ${position.inMilliseconds}');
        noteBloc.notes.forEach((myList) {
          myList.forEach((element) {
            if (noteSeen[element.position] == null) {
              noteSeen[element.position] = false;
            }

            if (element.position == position.inSeconds &&
                _controller.value.isPlaying &&
                !noteSeen[element.position]) {
              pauseAndPlayVideo();
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text('Notes'),
                        content: Text(element.noteDesc),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() async {
                                  noteSeen.forEach((key, value) {
                                    if (key == position.inSeconds) noteSeen[key] = true;
                                  });
                                  _controller.seekTo(
                                      await _controller.position + Duration(milliseconds: 4));
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                });
                              },
                              child: Text('Ok'))
                        ],
                      ));
            }
          });
        });

        if (duration.compareTo(position) != 1) {
          Navigator.pushReplacementNamed(context, '/quiz_page');
        }
      }
    };
    _controller
      ..addListener(listener)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _controller.play();
    noteBloc.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
        ),
        body: _controller.value.isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      pauseAndPlayVideo();
                    },
                    child: Stack(children: [
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                      Icon(
                        _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.black,
                      ),
                    ]),
                  ),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                  StreamBuilder(
                      stream: noteBloc.notes,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        if (snapshot.hasError) return Container();
                        List<NoteModel> notes = snapshot.data;

                        if (notes == null) return Container();
                        return Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: ListView.builder(
                              itemCount: notes.length,
                              itemBuilder: (_, index) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: NoteCard(noteModel: notes[index]));
                              }),
                        ));
                      })
                ],
              )
            : Center(child: CircularProgressIndicator()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            pauseAndPlayVideo();
            writeNote();
          },
          child: Icon(
            Icons.note_add,
          ),
        ),
      ),
    );
  }

  void pauseAndPlayVideo() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  void writeNote() {
    noteDescController.clear();
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Add Notes'),
              content: TextField(
                controller: noteDescController,
                decoration: InputDecoration(hintText: 'Write note here...'),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      pauseAndPlayVideo();
                    },
                    child: Text('cancel')),
                TextButton(
                    onPressed: () {
                      saveNote();
                    },
                    child: Text('Save'))
              ],
            ));
  }

  void saveNote() async {
    NoteModel note = NoteModel();
    note.noteDesc = noteDescController.text.toString();
    note.position = _controller.value.position.inSeconds;
    note.quizType = 'Math';
    noteBloc.addNote(note);
    Navigator.pop(context);
    noteBloc.getNotes();
    pauseAndPlayVideo();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
