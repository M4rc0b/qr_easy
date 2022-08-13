import 'package:flutter/material.dart';

import '../utils/styles.dart';

class MyButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const MyButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          fixedSize: Size(width, double.infinity),
          primary: Styles.sunRed,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      child: Text(label, style: Styles.myButtonTextStyle()),
    );
  }
}
