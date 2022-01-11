

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qreasy/bloc/qrcode_bloc.dart';
import 'package:qreasy/view/qrcode_detail_view.dart';
import 'package:qreasy/view/qrcode_scanned_view.dart';

class QRCodeScannerView extends StatefulWidget{

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
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          QRView(
            key: _qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      if(scanData.code != null){
        _bloc.saveNotificationData(data: scanData.code!);
        goToSuccessPage(scanData.code!);
      }
    });
  }

  goToSuccessPage(String data){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => QRCodeScannedView(
              qrData: data,
            )));
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

}