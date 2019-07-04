import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jappa/data/dto/meditation_list.dart';

import '../data_constants.dart';
import '../data_util.dart';
import 'local_service.dart';

class RemoteService {
  final _db = Firestore.instance;
  final _storage = FirebaseStorage.instance;
  final _localService = LocalService();

  Future<DocumentSnapshot> fetchMeditationList() async =>
      _db.collection(DataConstants.MEDITATION_LIST).document(DataConstants.MEDITATION_LIST_DOC_ID).get();

  Future<void> fetchIntroMed() => fetchFile(DataUtil.getIntroMedFileName());
  Future<void> fetchBgSounds() => fetchFile(DataUtil.getBackgroundFileName());


  Future<List<void>> fetchAudio(MeditationList meditationList, [bool fetchAll = false]) async {
    final futures = List<Future<void>>();
    if (fetchAll) {
      // eg "intro_med.mp3"
      futures
        ..add(fetchIntroMed())
        ..add(fetchBgSounds());
    }
    for (final m in meditationList.meditations) {
      // eg "1/desc.mp3"
      futures.add(fetchFile(DataUtil.getMedDescriptionFileName(m.key)));
      for (var i = 1; i <= m.numReminders; i++) {
        // eg "1/rem3.mp3
        futures.add(fetchFile(DataUtil.getMedReminderFileName(m.key, i)));
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
    final storageFile = await _localService.getAppStorageFile(fileName);
    StorageFileDownloadTask downloadTask = ref.writeToFile(storageFile);
    downloadTask.future.then((snap) {
      print("fetched $fileName with  byte count: ${snap.totalByteCount}");
    }).catchError((e) {
      print("could not fetch $fileName");
    });
  }
}
