


import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class QRCodeBloc {

  Future saveNotificationData({required String data, String desc = ""}) async {
    final list = Hive.box(Constants.bookmarkTag);
    DateTime now = DateTime.now();
    final timestamp = "${now.millisecondsSinceEpoch}";
    Map<String, dynamic> bookmark = {
      'timestamp': timestamp,
      'date': now.millisecondsSinceEpoch,
      'data': data,
      'desc': desc
    };
    await list.put(timestamp, bookmark);
  }

  Box<dynamic> loadBookMarks(){
    return Hive.box(Constants.bookmarkTag);
  }

  Future deleteBookmark(String timestamp) async {
      await Hive.box(Constants.bookmarkTag).delete(timestamp);
  }

  Future<dynamic> loadBookMark(String idData) async{
    return Hive.box(Constants.bookmarkTag).get(idData);
  }

}


class Constants {
  static const String bookmarkTag = "bookmarked_list";
}