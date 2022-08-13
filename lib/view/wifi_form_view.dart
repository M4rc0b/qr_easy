import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qreasy/view/qrcode_detail_view.dart';

import '../bloc/qrcode_bloc.dart';
import '../model/bookmark_model.dart';
import '../widgets/my_button_widget.dart';
import '../widgets/my_textfield_widget.dart';

class WifiFormView extends StatefulWidget {
  const WifiFormView({Key? key}) : super(key: key);

  @override
  State<WifiFormView> createState() => _WifiFormViewState();
}

class _WifiFormViewState extends State<WifiFormView> {
  String _ssid = "";
  String _password = "";

  _onSSidChanged(val) {
    if (kDebugMode) {
      print(val);
      _ssid = val;
    }
  }

  _onPasswordChanged(val) {
    if (kDebugMode) {
      print(val);
      _password = val;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            MyTextField(
              onChanged: _onSSidChanged,
              hintText: "SSID",
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              onChanged: _onPasswordChanged,
              hintText: "Password",
            ),
            const SizedBox(
              height: 40,
            ),
            MyButton(label: "Create", onTap: _onSave)
          ],
        ),
      ),
    );
  }

  _onSave() {
    String value =
        QRCodeBloc().buildWifiQRCodeValue(password: _password, ssid: _ssid);
    Bookmark bookmark = Bookmark(value: value, desc: "");
    QRCodeBloc().saveQrCode(bookmark: bookmark);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QRCodeDetailView(bookmark: bookmark),
        fullscreenDialog: true,
      ),
    );
  }
}
