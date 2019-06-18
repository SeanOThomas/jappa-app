import 'package:flutter/widgets.dart';
import 'package:jaap/domain/models/med_list_model.dart';
import 'package:jaap/domain/state/med_list_state.dart';
import 'package:jaap/presentation/error_message.dart';
import 'package:jaap/presentation/list/med_list_results.dart';
import 'package:jaap/presentation/loading_spinner.dart';
import 'package:provider/provider.dart';


class MedListPage extends StatelessWidget {
  static const ROUTE_NAME = '/';

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MedListModel>(context);
    return _getWidget(model);
  }

  Widget _getWidget(MedListModel model) {
    switch(model.state) {
      case ResultsWithAudio:
      case Results: {
        return MedListResults(model.medList.meditations);
      }
      case Error: {
        return ErrorMessage();
      }
      default: {
        return LoadingSpinner();
      }

    }

  }
}