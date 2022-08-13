import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qreasy/view/create_qr_view.dart';
import 'package:qreasy/view/qrcode_scanner_view.dart';

import '../utils/styles.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_button_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'QR Easy',
        listEnabled: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Create and Save \nQR Code Easily",
                  style: Styles.homeTitleTextStyle(),
                  textAlign: TextAlign.center,
                ),
                SvgPicture.asset(
                  "assets/svg/illustration.svg",
                ),
                const SizedBox(
                  height: 40,
                ),
                MyButton(
                  onTap: _onStartScan,
                  label: 'Scan QR',
                ),
                const SizedBox(
                  height: 40,
                ),
                MyButton(
                  onTap: _onCreate,
                  label: 'Create QR',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onStartScan() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const QRCodeScannerView(),
            fullscreenDialog: true));
  }

  void _onCreate() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const CreateQrView(), fullscreenDialog: true),
    );
  }
}
