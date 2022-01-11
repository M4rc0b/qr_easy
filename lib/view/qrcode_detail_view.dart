


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QRCodeDetailView extends StatefulWidget{

  final String qrData;

  const QRCodeDetailView({Key? key, required this.qrData}) : super(key: key);

  @override
  State<QRCodeDetailView> createState() => _QRCodeDetailViewState();
}

class _QRCodeDetailViewState extends State<QRCodeDetailView> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(body: Center(child: Text("result data: ${widget.qrData}")));
  }
}