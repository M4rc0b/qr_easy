import 'package:flutter/material.dart';
import 'package:qreasy/utils/styles.dart';

void openSnackBar(scaffoldKey, snackMessage) {
  scaffoldKey.currentState.showSnackBar(SnackBar(
    duration: const Duration(seconds: 1),
    content: Container(
      alignment: Alignment.centerLeft,
      height: 60,
      child: Text(
        snackMessage,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    ),
    action: SnackBarAction(
      label: 'Ok',
      textColor: Styles.pink,
      onPressed: () {},
    ),
  ));
}
