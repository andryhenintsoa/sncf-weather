import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final dateFormat = DateFormat("yyyy-MM-dd");
final dateTimeFormatDisplay = DateFormat("EEE, dd MMM, HH:mm");
final onlyTimeFormatDisplay = DateFormat("HH:mm");

Future showListAlert(
  BuildContext context,
  String title, {
  Widget? content,
  VoidCallback? callback,
  List<AlertButton> otherButtons = const [],
}) async {
  if (Platform.isAndroid) {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: content == null
                  ? null
                  : ListBody(
                      children: <Widget>[
                        content,
                      ],
                    ),
            ),
            actions: <Widget>[
              for (AlertButton item in otherButtons)
                TextButton(
                  onPressed: item.callback,
                  child: Text(item.text),
                ),
            ],
          );
        });
  } else if (Platform.isIOS) {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(title),
          message: content,
          actions: <Widget>[
            for (AlertButton item in otherButtons)
              CupertinoActionSheetAction(
                onPressed: item.callback,
                child: Text(item.text),
              ),
          ],
        );
      },
    );
  }
  return null;
}

class AlertButton {
  final String text;
  final VoidCallback callback;

  AlertButton(this.text, this.callback);
}
