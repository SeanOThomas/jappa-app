import 'meditation.dart';

class MeditationList {
  final String version;
  final List<Meditation> meditations;

  MeditationList(this.version, this.meditations);

  factory MeditationList.fromJson(Map json) {
    List<Meditation> meditations = new List();

    for (var m in json['meditations']) {
      meditations.add(new Meditation.fromJson(m));
    }

    return MeditationList(json['version'].toString(), meditations);
  }
}
