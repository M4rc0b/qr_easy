import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qreasy/bloc/qrcode_bloc.dart';
import 'package:qreasy/model/bookmark_model.dart';
import 'package:qreasy/view/qrcode_detail_view.dart';
import 'package:qreasy/widgets/my_app_bar.dart';

class QRCodeScannerView extends StatefulWidget {
  const QRCodeScannerView({Key? key}) : super(key: key);

  @override
  State<QRCodeScannerView> createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<QRCodeScannerView> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;
  final QRCodeBloc _bloc = QRCodeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: '',
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          QRView(
            key: _qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Image.asset(
            "assets/images/scan.png",
            width: 300,
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    controller.scannedDataStream.listen((scanData) {
      try {
        controller.pauseCamera();
        if (scanData.code != null) {
          controller.stopCamera();
          _bloc.saveQrCode(bookmark: Bookmark(value: scanData.code!, desc: ""));
          goToSuccessPage(scanData.code!);
        }
      } catch (e, stack) {
        if (kDebugMode) {
          print(e.toString());
          print(stack);
        }
      }
    });
  }

  goToSuccessPage(String data) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QRCodeDetailView(
          bookmark: Bookmark(value: data, desc: ""),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}
