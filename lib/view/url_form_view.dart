import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qreasy/model/bookmark_model.dart';
import 'package:qreasy/view/qrcode_detail_view.dart';
import 'package:qreasy/widgets/my_button_widget.dart';

import '../bloc/qrcode_bloc.dart';
import '../widgets/my_textfield_widget.dart';

class UrlFormView extends StatefulWidget {
  const UrlFormView({Key? key}) : super(key: key);

  @override
  State<UrlFormView> createState() => _UrlFormViewState();
}

class _UrlFormViewState extends State<UrlFormView> {
  String _qrValue = "";
  String _qrDescValue = "";

  _onChanged(val) {
    _qrValue = val;
  }

  _onDescChanged(val) {
    _qrDescValue = val;
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
              onChanged: _onChanged,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              onChanged: _onDescChanged,
              hintText: "Short desc",
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

  _onSave() async {
    Bookmark bookmark = Bookmark(value: _qrValue, desc: _qrDescValue);
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
