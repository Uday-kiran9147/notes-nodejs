// ignore_for_file: public_member_api_docs, sort_constructors_first
class Note {
  String? id;
  String? userid;
  String? title;
  String? content;
  DateTime? datetime;

  Note({
    this.id,
    this.userid,
    this.title,
    this.content,
    this.datetime,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
        id: map["id"],
        userid: map['userid'],
        title: map['title'],
        content: map['content'],
        datetime: DateTime.tryParse(map['dateadded']));
  }

  //returns a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userid': userid,
      'title': title,
      'content': content,
      'datetime': datetime!.toIso8601String()
    };
  }
}
