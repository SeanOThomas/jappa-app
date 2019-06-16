import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaap/data/dto/meditation_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const MEDITATION_LIST = "meditation_list";
const MEDITATION_LIST_DOC_ID = "70cGhL4xdSHIldutJcyQ";

const FILE_NAME_INTRO_MEDITATION = "intro_med";
const FILE_NAME_DESCRIPTION = "desc";
const FILE_NAME_REMINDER = "rem";

const KEY_MED_LIST = "key_med_list";

class RemoteService {
  final _db = Firestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<MeditationList> fetch() async {
    print('feching med list...');
    return _fetchMeditationList().then((snapshot) async {
      MeditationList medList = MeditationList.fromJson(snapshot.data);

      // determine what we should fetch based on remote version against
      // local version.
      final prefs = await SharedPreferences.getInstance();
      final medListLocalJson = prefs.get(KEY_MED_LIST);
      if (medListLocalJson != null) {
        final medListLocal =
            MeditationList.fromJson(json.decode(medListLocalJson));
        if (medListLocal.version == medList.version) {
          print('remote version is the same, no audio to fetch');
        } else if (medListLocal.version[0] == medList.version[0]) {
          print('versions are different, fetch audio without intro');
          _fetchAudio(medList);
        } else {
          print('versions are different, fetch all audio');
          _fetchAudio(medList, _fetchIntroMed());
        }
      } else {
        print('no saved med list, fetch all audio');
        _fetchAudio(medList, _fetchIntroMed());
      }
      // store remote med list
      prefs.setString(KEY_MED_LIST, json.encode(snapshot.data));
      return medList;
    });
  }

  Future<DocumentSnapshot> _fetchMeditationList() async =>
      _db.collection(MEDITATION_LIST).document(MEDITATION_LIST_DOC_ID).get();

  Future<void> _fetchIntroMed() =>
      _fetchFile(_plusFileExt(FILE_NAME_INTRO_MEDITATION));

  Future<List<void>> _fetchAudio(MeditationList meditationList,
      [Future<void> introMedFuture]) async {
    final futures = List<Future<void>>();
    if (introMedFuture != null) {
      // eg "intro_med.mp3"
      futures.add(introMedFuture);
    }
    for (final m in meditationList.meditations) {
      // eg "1/desc.mp3"
      futures.add(_fetchFile(_plusFileExt('${m.key}/$FILE_NAME_DESCRIPTION')));
      for (var i = 1; i <= m.numReminders; i++) {
        // eg "1/rem3.mp3
        futures.add(_fetchFile(_plusFileExt('${m.key}/$FILE_NAME_REMINDER$i')));
      }
    }
    return Future.wait(futures);
  }

  String _plusFileExt(String fileName) => '$fileName.mp3';

  /// Fetches a remote file and saves it to private app storage.
  ///
  /// Takes  a file name, eg "intro_med.mp3",  "1/desc.mp3" or
  /// "1/rem3.mp3"
  Future<void> _fetchFile(String fileName) async {
    StorageReference ref = _storage.ref().child(fileName);
    print('fetching fileName: $fileName');
    final storageFile = await _getAppStorageFile(fileName);
    print('storage file: ${storageFile.path}');
    StorageFileDownloadTask downloadTask = ref.writeToFile(storageFile);
    downloadTask.future.then((snap) {
      print("fetched $fileName with  byte count: ${snap.totalByteCount}");
    }).catchError((e) {
      print("could not fetch $fileName");
    });
  }

  /// Gets a file in private app storage.
  ///
  /// Takes  a file name, eg "intro_med.mp3",  "1/desc.mp3" or
  /// "1/rem3.mp3"
  Future<File> _getAppStorageFile(String fileName) async {
    final path = await _getAppStoragePath();
    File file = await File('$path/$fileName').create(recursive: true);

    print('local dir path: ${file.path}');
    return File('$path/$fileName');
  }

  /// Get path to private app storage.
  Future<String> _getAppStoragePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }
}
