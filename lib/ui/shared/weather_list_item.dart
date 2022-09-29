import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../core/model/weather.dart';
import '../../util/utils.dart';
import '../styling.dart';
import 'shimmer_container.dart';

class WeatherListItem extends StatefulWidget {
  final Weather data;
  final Animation<double>? animation;
  final bool isLastItem;
  final BuildContext context;
  final double? customPadding;
  final VoidCallback? onDelete;

  const WeatherListItem(
    this.context, {
    required this.data,
    Key? key,
    this.animation,
    this.isLastItem = false,
    this.customPadding,
    this.onDelete,
  }) : super(key: key);

  @override
  _WeatherListItemState createState() => _WeatherListItemState();
}

class _WeatherListItemState extends State<WeatherListItem> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    Weather data = widget.data;

    double customPadding = widget.customPadding ?? 16.0;

    Widget content = Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      margin: EdgeInsets.only(bottom: widget.isLastItem ? 56.0 : 0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: customPadding),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: lightGreyColor(),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          image: DecorationImage(
                            image: NetworkImage(
                              "http://openweathermap.org/img/w/${data.weather.first.icon}.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(data.dateTimeHumanDescription,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              data.weather.map((e) => e.main).join(" • "),
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    data.weather
                                        .map((e) => e.description)
                                        .join(" • "),
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Icon(
                                  Icons.thermostat,
                                  color: mainColor(),
                                ),
                                Text(
                                  "${data.main.tempMin}°C - ${data.main.tempMax}°C",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .apply(
                                        color: mainColor(),
                                        fontWeightDelta: 1,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        content,
        const Divider(
          height: 1,
          indent: 12,
          endIndent: 12,
        ),
      ],
    );

    if (widget.animation == null) return content;

    return SizeTransition(
      sizeFactor: widget.animation!,
      child: content,
    );
  }
}

class WeatherListItemShimmer extends StatelessWidget {
  final double? padding;

  const WeatherListItemShimmer({Key? key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double customPadding = padding ?? 16.0;

    Widget content = Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: customPadding),
                  child: Row(
                    children: <Widget>[
                      const ShimmerContainer(
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ShimmerContainer.text(
                              width: 100,
                              randomRangeWidth: 200,
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ShimmerContainer.text(
                                  width: 40,
                                  randomRangeWidth: 100,
                                ),
                                const SizedBox(width: 8.0),
                                ShimmerContainer.text(
                                  width: 40,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            ShimmerContainer.text(
                              width: 200,
                              randomRangeWidth: 200,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        content,
        const Divider(
          height: 1,
          indent: 12,
          endIndent: 12,
          color: Colors.white,
        ),
      ],
    );
    return content;
  }
}
