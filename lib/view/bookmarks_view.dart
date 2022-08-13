import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qreasy/utils/constants.dart';
import 'package:qreasy/view/qrcode_detail_view.dart';
import 'package:qreasy/widgets/my_app_bar.dart';

import '../bloc/qrcode_bloc.dart';
import '../model/bookmark_model.dart';
import '../utils/styles.dart';

class BookmarksView extends StatefulWidget {
  const BookmarksView({Key? key}) : super(key: key);

  @override
  State<BookmarksView> createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<BookmarksView> {
  late List items;
  final QRCodeBloc _bloc = QRCodeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: '',
        ),
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: Hive.box(bookmarkTag).listenable(),
            builder: (BuildContext context, value, Widget? child) {
              return _bloc.findAll().isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: SvgPicture.asset(
                            "assets/svg/empty_list.svg",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text("No Qr Code yet!",
                              style: Styles.normalTextStyle()),
                        )
                      ],
                    )
                  : GridView.count(
                      childAspectRatio: (0.7),
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: _bloc
                          .findAll()
                          .map((e) => _QRItemWidget(bookmark: e))
                          .toList());
            },
          ),
        ));
  }
}

class _QRItemWidget extends StatefulWidget {
  final Bookmark bookmark;

  const _QRItemWidget({Key? key, required this.bookmark}) : super(key: key);

  @override
  State<_QRItemWidget> createState() => _QRItemWidgetState();
}

class _QRItemWidgetState extends State<_QRItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QRCodeDetailView(
                    bookmark: widget.bookmark,
                  ),
              fullscreenDialog: true),
        );
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Styles.grey, width: 1)),
        child: Stack(
          children: [
            Column(
              children: [
                QrImage(
                  semanticsLabel: widget.bookmark.desc,
                  data: widget.bookmark.value,
                  version: QrVersions.auto,
                  //size: 150.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.bookmark.toDesc(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                )
              ],
            ),
            widget.bookmark.favorite
                ? const Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        FontAwesomeIcons.heart,
                        color: Colors.red,
                        size: 15,
                      ),
                    ),
                  )
                : const IgnorePointer()
          ],
        ),
      ),
    );
  }
}
