import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jaap/data/dto/meditation_list.dart';
import 'package:path_provider/path_provider.dart';

const MEDITATION_LIST = "meditation_list";
const MEDITATION_LIST_DOC_ID = "70cGhL4xdSHIldutJcyQ";

const FILE_NAME_INTRO_MEDITATION = "intro_med";
const FILE_NAME_DESCRIPTION = "desc";
const FILE_NAME_REMINDER = "rem";

const KEY_MED_LIST = "key_med_list";

class RemoteService {
  final _db = Firestore.instance;
  final _storage = FirebaseStorage.instance;


  Future<DocumentSnapshot> fetchMeditationList() async =>
      _db.collection(MEDITATION_LIST).document(MEDITATION_LIST_DOC_ID).get();

  Future<void> fetchIntroMed() =>
      fetchFile(_plusFileExt(FILE_NAME_INTRO_MEDITATION));

  Future<List<void>> fetchAudio(MeditationList meditationList,
      [Future<void> introMedFuture]) async {
    final futures = List<Future<void>>();
    if (introMedFuture != null) {
      // eg "intro_med.mp3"
      futures.add(introMedFuture);
    }
    for (final m in meditationList.meditations) {
      // eg "1/desc.mp3"
      futures.add(fetchFile(_plusFileExt('${m.key}/$FILE_NAME_DESCRIPTION')));
      for (var i = 1; i <= m.numReminders; i++) {
        // eg "1/rem3.mp3
        futures.add(fetchFile(_plusFileExt('${m.key}/$FILE_NAME_REMINDER$i')));
      }
    }
    return Future.wait(futures);
  }

  /// Fetches a remote file and saves it to private app storage.
  ///
  /// Takes  a file name, eg "intro_med.mp3",  "1/desc.mp3" or
  /// "1/rem3.mp3"
  Future<void> fetchFile(String fileName) async {
    StorageReference ref = _storage.ref().child(fileName);
    print('fetching fileName: $fileName');
    final storageFile = await _getAppStorageFile(fileName);
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
    return File('$path/$fileName');
  }

  /// Get path to private app storage.
  Future<String> _getAppStoragePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  String _plusFileExt(String fileName) => '$fileName.mp3';
}
