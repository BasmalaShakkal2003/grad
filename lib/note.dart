 
class Note {
  final String day;
  final String date;
  final String title;
  final String author;
  final String time;
  final String meetingType;

  Note({
    required this.day,
    required this.date,
    required this.title,
    required this.author,
    required this.time,
    required this.meetingType,
  });
 
 
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      day: json['day'],
      date: json['date'],
      title: json['title'],
      author: json['author'],
      time: json['time'],
      meetingType: json['type'],
    );
  }

  
  Map<String, dynamic> toJson() => {
    'day': day,
    'date': date,
    'title': title,
    'author': author,
    'time': time,
    'meeting type' : meetingType,
  };
} 