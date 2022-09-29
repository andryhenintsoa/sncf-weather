import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/base_view.dart';
import '../../core/enum/view_state.dart';
import '../../core/model/user.dart';
import '../../core/model/weather.dart';
import '../../core/service/authentification_service.dart';
import '../../core/service_locator.dart';
import '../../core/viewmodel/weather_model.dart';
import '../../util/utils.dart';
import '../shared/weather_list_item.dart';
import '../styling.dart';

class WeatherScreen extends StatelessWidget {
  static const String route = "weather";

  WeatherScreen({Key? key}) : super(key: key);

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  static const double contentPadding = 16.0;
  final List<Weather> weathers = [];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<WeatherModel>(
        onModelReady: (model) => model.getWeathers(),
        builder: (context, model, child) {
          _addNewItems(model.weathers);

          if (model.needToShowError && weathers.isNotEmpty) {
            Fluttertoast.showToast(
              msg: "Erreur de connexion",
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
            );
          }
          model.needToShowError = false;

          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                elevation: 4.0,
                backgroundColor: Colors.white,
                actions: [
                  IconButton(
                    onPressed: () {
                      locator<AuthenticationService>().logout();
                    },
                    icon: Icon(
                      Icons.logout,
                      color: mainTextColor(),
                    ),
                  ),
                ],
                centerTitle: true,
                title: Text(
                  "Bienvenue ${Provider.of<User>(context).username}",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              body: Container(
                color: lightGreyColor(),
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: <Widget>[
                    RefreshIndicator(
                      onRefresh: () {
                        return _reloadContent(model);
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                top: 16.0,
                                right: 16.0,
                                left: 16.0,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Météo à ${model.city} ",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _textFieldController.text = "";
                                          showListAlert(
                                            context,
                                            "Choisir une ville",
                                            content: TextField(
                                              controller: _textFieldController,
                                              decoration: const InputDecoration(
                                                hintText: "Nom de la ville",
                                              ),
                                            ),
                                            callback: () {},
                                            otherButtons: [
                                              AlertButton("Annuler", () {
                                                Navigator.pop(context);
                                              }),
                                              AlertButton(
                                                "Ok",
                                                () {
                                                  _reloadContent(
                                                    model,
                                                    newCity:
                                                        _textFieldController
                                                            .text,
                                                    removeAllNow: true,
                                                  );
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .apply(
                                              color: mainColor(),
                                              decoration:
                                                  TextDecoration.underline),
                                      text: "(Changer)",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (model.state == ViewState.busy &&
                                model.weathers.isEmpty)
                              Container(
                                color: Colors.white,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  enabled: true,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: (_, __) =>
                                        const WeatherListItemShimmer(
                                      padding: WeatherScreen.contentPadding,
                                    ),
                                    itemCount: 6,
                                  ),
                                ),
                              ),
                            AnimatedList(
                              key: _listKey,
                              initialItemCount: weathers.length,
                              controller: ScrollController(),
                              physics: null,
                              shrinkWrap: true,
                              itemBuilder: (context, index, animation) {
                                Weather data = weathers[index];
                                return WeatherListItem(
                                  context,
                                  data: data,
                                  animation: animation,
                                  customPadding: WeatherScreen.contentPadding,
                                  isLastItem: index == weathers.length - 1,
                                  onDelete: () {},
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (model.errorMessage != null &&
                        weathers.isEmpty &&
                        model.state == ViewState.idle)
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            MaterialButton(onPressed: () {}),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  model.errorMessage!,
                                ),
                                const SizedBox(height: 8.0),
                                GestureDetector(
                                  onTap: () {
                                    _reloadContent(model);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 8.0,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: darkGreyColor(),
                                        width: 2.0,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                    child: const Text("Réessayer"),
                                  ),
                                ),
                              ],
                            ),
                            if (model.state == ViewState.busy)
                              const Positioned(
                                top: 8.0,
                                child: RefreshProgressIndicator(),
                              ),
                          ],
                        ),
                      ),
                    if (model.errorMessage == null &&
                        weathers.isEmpty &&
                        model.state == ViewState.idle)
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            MaterialButton(onPressed: () {}),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  "Aucune donnée pour cette ville",
                                ),
                                const SizedBox(height: 8.0),
                                GestureDetector(
                                  onTap: () {
                                    _reloadContent(model);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 8.0,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: darkGreyColor(),
                                        width: 2.0,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                    child: const Text("Choisir une autre"),
                                  ),
                                ),
                              ],
                            ),
                            if (model.state == ViewState.busy)
                              const Positioned(
                                top: 8.0,
                                child: RefreshProgressIndicator(),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _reloadContent(
    WeatherModel model, {
    String? newCity,
    bool removeAllNow = false,
  }) async {
    if (removeAllNow) {
      _removeAllItems();
    }
    await model.getWeathers(
        newCity: newCity ?? model.city,
        onSuccess: () {
          if (!removeAllNow) {
            _removeAllItems();
          }
        });
    return;
  }

  void _addAnItem(Weather item, {bool onTop = false}) {
    if (onTop) {
      weathers.insert(0, item);
      _listKey.currentState?.insertItem(0);
    } else {
      weathers.insert(weathers.length, item);
      _listKey.currentState?.insertItem(weathers.length - 1);
    }
  }

  void _addNewItems(List<Weather> newWeathers) {
    for (Weather item in newWeathers) {
      if (!weathers.contains(item)) {
        _addAnItem(item);
      }
    }
  }

  void _removeAllItems() {
    final int itemCount = weathers.length;

    for (var i = 0; i < itemCount; i++) {
      _listKey.currentState?.removeItem(
        0,
        (BuildContext context, Animation<double> animation) =>
            WeatherListItem(context, data: weathers[0], animation: animation),
      );

      weathers.removeAt(0);
    }
  }
}
