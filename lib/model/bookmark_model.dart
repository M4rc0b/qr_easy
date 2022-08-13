import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../utils/constants.dart';

class Bookmark {
  int? id;
  final String value;
  final String desc;
  bool favorite;
  int? timestamp;

  Bookmark(
      {required this.value,
      required this.desc,
      this.timestamp,
      this.id,
      this.favorite = false});

  get bookmark => null;

  Future<void> save() async {
    timestamp = DateTime.now().millisecondsSinceEpoch;
    var bookmarks = Hive.box(bookmarkTag);
    id = await bookmarks.add(toMap());
  }

  loadAll() async {
    var bookmarks = Hive.box(bookmarkTag).values;
    for (var element in bookmarks) {
      if (kDebugMode) {
        print(element);
      }
    }
    return bookmarks;
  }

  toMap() {
    return {
      "value": value,
      "desc": desc,
      "timestamp": timestamp,
      "favorite": favorite
    };
  }

  toDesc() {
    if (value.startsWith("WIFI")) {
      return "WIFI";
    } else {
      return value;
    }
    return desc;
  }

  void toggleFavorite() {
    if (id == null) return;
    favorite = !favorite;
    Hive.box(bookmarkTag).put(id!, toMap());
  }

  void delete() async {
    if (id == null) return;
    await Hive.box(bookmarkTag).delete(id!);
  }
}
