class Comment {
  Comment({required this.name, required this.text, required this.month, required this.day, required this.hour, required this.minute});
  String name;
  String text;
  String month;
  int day;
  int hour;
  int minute;

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      name: json['name'],
      month: json['month'],
      day: json['day'],
      hour: json['hour'],
      minute: json['minute'],
      text: json['text']
    );
  }
}