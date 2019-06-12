import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaap/data/dto/meditation_list.dart';
import 'package:firebase_storage/firebase_storage.dart';

const MEDITATION_LIST = "meditation_list";
const MEDITATION_LIST_DOC_ID = "70cGhL4xdSHIldutJcyQ";

class RemoteService {
  final Firestore db = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<MeditationList> getMeditationList() async => db
          .collection(MEDITATION_LIST)
          .document(MEDITATION_LIST_DOC_ID)
          .get()
          .then((snapshot) {
        return MeditationList.fromJson(snapshot.data);
      });

  Future<Null> fetchFile(String fileName) {

    StorageReference ref = storage.ref().child(fileName);
//    StorageFileDownloadTask downloadTask = ref.writeToFile(myLocalFile);
//    downloadTask.future.then((snap) {
//
//    });

    return null;
  }

}
