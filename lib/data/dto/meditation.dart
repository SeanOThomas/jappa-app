class Meditation {
  final String key;
  final int type;
  final String title;
  final String description;
  final int numReminders;

  Meditation({this.key, this.type, this.title, this.description, this.numReminders});

  factory Meditation.fromJson(Map json) {
    return Meditation(
        key: json['key'],
        type: json['type'],
        title: json['title'],
        description: json['description'],
        numReminders: json['numReminders']
    );
  }
}
