import 'package:jaap/data/dto/meditation_list.dart';
import 'package:jaap/data/services/remote_service.dart';
import 'package:jaap/domain/models/base_model.dart';
import 'package:jaap/domain/state/med_list_state.dart';

class MedListModel<MedListState> extends BaseModel {
  MeditationList medList;

  final _remoteService = RemoteService();

  MedListModel(state) : super(state);

  void fetchMedList() async {
    setState(Loading);

    medList = await _remoteService.fetch();
    if (medList != null) {
      setState(Results);
    } else {
      setState(Error);
    }
  }
}