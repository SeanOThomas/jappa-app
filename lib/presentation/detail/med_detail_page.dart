import 'package:flutter/widgets.dart';
import 'package:jaap/domain/models/med_list_model.dart';
import 'package:jaap/domain/state/med_list_state.dart';
import 'package:provider/provider.dart';

import '../error_message.dart';
import '../loading_spinner.dart';

class MedDetailPage extends StatelessWidget {
  static const ROUTE_NAME = '/detail';

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MedListModel>(context);
    return _getWidget(model);
  }

  Widget _getWidget(MedListModel model) {
    switch (model.state) {
      case ResultsWithAudio:
        {
          return Center(child: Text(ROUTE_NAME));
        }
      case Error:
        {
          return ErrorMessage();
        }
      default:
        {
          return LoadingSpinner();
        }
    }
  }
}
