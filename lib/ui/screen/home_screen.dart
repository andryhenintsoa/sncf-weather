import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/base_view.dart';
import '../../core/enum/view_state.dart';
import '../../core/model/user.dart';
import '../../core/viewmodel/app_model.dart';
import 'loading_screen.dart';
import 'sign_in_screen.dart';
import 'weather_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AppModel>(
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.state == ViewState.busy) {
            return const LoadingScreen();
          }
          var currentUser = Provider.of<User?>(context);
          if (currentUser == null) {
            return const SignInScreen();
          }

          return WeatherScreen();
        });
  }
}
