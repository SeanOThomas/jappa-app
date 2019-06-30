import 'package:flutter/widgets.dart';
import 'package:jappa/domain/models/med_list_model.dart';
import 'package:jappa/domain/state/med_list_state.dart';
import 'package:jappa/presentation/error_message.dart';
import 'package:jappa/presentation/list/med_list_results.dart';
import 'package:jappa/presentation/splash/splash_page.dart';
import 'package:provider/provider.dart';

import '../loading_spinner.dart';


class MedListPage extends StatelessWidget {
  static const ROUTE_NAME = '/';

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MedListModel>(context);
    return _getWidget(model);
  }

  Widget _getWidget(MedListModel model) {
    switch(model.state.runtimeType) {
      case ResultsWithAudio:
      case Results: {
        return MedListResults(model.medList.meditations);
      }
      case Error: {
        return ErrorMessage();
      }
      case Start: {
        return SplashPage();
      }
      default: {
        return LoadingSpinner();
      }

    }

  }
}