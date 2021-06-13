final String tableName = 'note';
final String columnOne = 'type';
final String columnTwo = 'position';
final String columnThree = 'noteDesc';


class NoteModel{
  String quizType;
  int position;
   String noteDesc;

  NoteModel();

  // NoteModel({this.quizType,this.position,this.noteDesc});
  NoteModel.fromMap(Map<String, dynamic> map) {
    quizType = map[columnOne];
    position = map[columnTwo];
    noteDesc = map[columnThree];

  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnOne: quizType,
      columnTwo: position,
      columnThree: noteDesc,
    };
    return map;
  }
}