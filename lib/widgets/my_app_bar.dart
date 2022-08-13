import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/styles.dart';
import '../view/bookmarks_view.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool listEnabled;
  const MyAppBar({Key? key, required this.title, this.listEnabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Styles.sunRed,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w300)),
      elevation: 0,
      centerTitle: false,
      actions: [
        listEnabled
            ? InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookmarksView(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(FontAwesomeIcons.list),
                ),
              )
            : const IgnorePointer(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
