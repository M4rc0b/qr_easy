import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/bookmark_model.dart';
import '../utils/constants.dart';

class QRCodeBloc {
  Future saveQrCode({required Bookmark bookmark}) async {
    try {
      final qrValidationResult = QrValidator.validate(
        data: bookmark.value,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      );
      if (qrValidationResult.status == QrValidationStatus.valid) {
        bookmark.save();
      }
      qrValidationResult.error;
    } catch (e, stack) {
      if (kDebugMode) {
        print(e);
        rethrow;
      }
    }
  }

  Box<dynamic> loadBookMarks() {
    return Hive.box(bookmarkTag);
  }

  Future deleteBookmark(String timestamp) async {
    await Hive.box(bookmarkTag).delete(timestamp);
  }

  Future<dynamic> loadBookMark(String idData) async {
    return Hive.box(bookmarkTag).get(idData);
  }

  share(Bookmark bookmark) async {
    String path = await createQrPicture(bookmark.value);
    await Share.shareFiles([path],
        mimeTypes: ["image/png"],
        subject: 'My QR code',
        text: 'Please scan me');
  }

  Future<String> createQrPicture(String qr) async {
    final qrValidationResult = QrValidator.validate(
      data: qr,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    final painter = QrPainter.withQr(
      qr: qrValidationResult.qrCode!,
      color: const ui.Color(0xFF000000),
      gapless: true,
      embeddedImageStyle: null,
      embeddedImage: null,
    );

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    String path = '$tempPath/$ts.png';

    final picData =
        await painter.toImageData(2048, format: ui.ImageByteFormat.png);
    await writeToFile(picData!, path);

    return path;
  }

  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  //T:<WPA|WEP|>
  buildWifiQRCodeValue({
    required String ssid,
    required String password,
    String enc = "WPA",
  }) {
    return "WIFI:S:$ssid:;T:$enc;P:$password;;";
  }

  List<Bookmark> findAll() {
    List<Bookmark> list = [];
    Hive.box(bookmarkTag).toMap().forEach((key, value) {
      list.add(Bookmark(
          value: value["value"],
          desc: value["desc"],
          id: key,
          favorite: value["favorite"],
          timestamp: value["timestamp"]));
    });
    return list;
  }

  Future<bool> tryToLaunch(String val) async {
    try {
      final Uri url = Uri.parse(val);
      if (!await launchUrl(url)) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<bool> canLaunch(String val) async {
    try {
      final Uri url = Uri.parse(val);
      return await canLaunchUrl(url);
    } catch (e) {
      return false;
    }
  }
}
