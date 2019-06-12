class Meditation {
  final int key;
  final String title;
  final String description;
  final int numReminders;

  Meditation({this.key, this.title, this.description, this.numReminders});

  factory Meditation.fromJson(Map json) {
    return Meditation(
        key: json['key'],
        title: json['title'],
        description: json['description'],
        numReminders: json['numReminders']
    );
  }
}
