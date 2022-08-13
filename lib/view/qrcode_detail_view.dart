import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qreasy/bloc/qrcode_bloc.dart';
import 'package:qreasy/model/bookmark_model.dart';
import 'package:qreasy/utils/snack_bar.dart';

import '../utils/styles.dart';
import '../widgets/my_app_bar.dart';

class QRCodeDetailView extends StatefulWidget {
  final Bookmark bookmark;

  const QRCodeDetailView({
    Key? key,
    required this.bookmark,
  }) : super(key: key);

  @override
  State<QRCodeDetailView> createState() => _QRCodeDetailViewState();
}

class _QRCodeDetailViewState extends State<QRCodeDetailView> {
  final QRCodeBloc _bloc = QRCodeBloc();
  final GlobalKey _globalKey = GlobalKey();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(title: ""),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: RepaintBoundary(
                  key: _globalKey,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Styles.grey,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Styles.grey, width: 1)),
                    child: QrImage(
                      data: widget.bookmark.value,
                      version: QrVersions.auto,
                      size: 150.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  bool check = await _bloc.tryToLaunch(widget.bookmark.value);
                  if (!check) {
                    openSnackBar(scaffoldKey, "It's not a valid link.");
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Styles.grey,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Styles.grey, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.bookmark.toDesc(),
                        style: Styles.smallTextStyle(),
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      ),
                      FutureBuilder<bool>(
                          future: _bloc.canLaunch(widget.bookmark.value),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data!) {
                              return const Icon(FontAwesomeIcons.link);
                            }
                            return const IgnorePointer();
                          })
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _ActionWidget(
                icon: const Icon(FontAwesomeIcons.share),
                title: "Share",
                onTap: () {
                  _bloc.share(widget.bookmark);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              _ActionWidget(
                icon: Icon(widget.bookmark.favorite
                    ? FontAwesomeIcons.heartCircleMinus
                    : FontAwesomeIcons.heartCirclePlus),
                title: widget.bookmark.favorite
                    ? "Remove From Favorites"
                    : "Add To Favorites",
                onTap: () {
                  setState(() {
                    widget.bookmark.toggleFavorite();
                  });
                },
              ),
              const SizedBox(
                height: 60,
              ),
              _ActionWidget(
                icon: const Icon(FontAwesomeIcons.trash),
                title: "Delete",
                onTap: () {
                  widget.bookmark.delete();
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        ));
  }
}

class _ActionWidget extends StatelessWidget {
  const _ActionWidget({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: Styles.pink,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Styles.grey, width: 1)),
      child: ListTile(
        onTap: onTap,
        leading: icon,
        title: Text(title, style: Styles.normalTextStyle()),
        trailing: const Icon(FontAwesomeIcons.arrowRight),
      ),
    );
  }
}
