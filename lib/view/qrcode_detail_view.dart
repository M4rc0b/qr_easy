import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qreasy/bloc/qrcode_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class QRCodeDetailView extends StatefulWidget {
  final String idData;

  const QRCodeDetailView({Key? key, required this.idData}) : super(key: key);

  @override
  State<QRCodeDetailView> createState() => _QRCodeDetailViewState();
}

class _QRCodeDetailViewState extends State<QRCodeDetailView> {

  final QRCodeBloc _bloc = QRCodeBloc();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("")
      ),
      body: SafeArea(
        child: FutureBuilder<dynamic>(
          future: _bloc.loadBookMark(widget.idData),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: QrImage(
                        data: snapshot.data!["data"],
                        version: QrVersions.auto,
                        size: 150.0,
                      ),
                    ),
                    Text("result data: ${snapshot.data["data"]}"),
                  ]
              );
            }else{
             return Container();
            }
          }
        ),
      )
    );
  }


}
