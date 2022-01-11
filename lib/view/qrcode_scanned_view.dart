

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qreasy/bloc/qrcode_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class QRCodeScannedView extends StatefulWidget{

  final String qrData;

  const QRCodeScannedView({Key? key, required this.qrData}) : super(key: key);

  @override
  State<QRCodeScannedView> createState() => _QRCodeScannedViewState();
}

class _QRCodeScannedViewState extends State<QRCodeScannedView> {

  final QRCodeBloc _bloc = QRCodeBloc();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("")
        ),
        bottomSheet: _buildButton(context),
        body: SafeArea(
          child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: QrImage(
                    data: widget.qrData,
                    version: QrVersions.auto,
                    size: 150.0,
                  ),
                ),
                Text("result data: ${widget.qrData}"),
              ]
          ),
        )
    );
  }

  _buildButton(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      child: RoundedLoadingButton(
        color: Colors.amber,
        successColor: Colors.amber,
        controller: _btnController,
        onPressed: () => _onSave(),
        valueColor: Colors.black,
        borderRadius: 10,
        child: Text("Save", style: Theme.of(context).textTheme.headline5),
      ),
    );
  }

  void _onSave() async{
    try{
      await _bloc.saveNotificationData(data: widget.qrData);
      _btnController.success();
    }catch(error){
      _btnController.error();
    }
  }
}