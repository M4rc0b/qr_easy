import 'package:flutter/material.dart';
import 'package:qreasy/utils/theme.dart';
import 'package:qreasy/view/qrcode_scanner_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeModel().lightTheme,
      darkTheme: ThemeModel().darkTheme,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SCAN QR CODE"),
      ),
      body: SafeArea(
        child: ListView(
          children:  [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: _onStartScan,
                    child: const Text("Scan QR Code")
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  void _onStartScan() {
    Navigator.push(context,
        MaterialPageRoute(
        builder: (context) => const QRCodeScannerView()));
  }
}
