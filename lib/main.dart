import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qreasy/utils/config.dart';
import 'package:qreasy/utils/theme.dart';
import 'package:qreasy/view/qrcode_detail_view.dart';
import 'package:qreasy/view/qrcode_scanner_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bloc/qrcode_bloc.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox(Constants.bookmarkTag);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //theme: ThemeModel().lightTheme,
      //darkTheme: ThemeModel().darkTheme,
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

  final QRCodeBloc _bloc = QRCodeBloc();


  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(Config().appName),
      ),
      bottomSheet: _buildButton(context),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:  [
            ListTile(
              title: Text("Recents", style: Theme.of(context).textTheme.headline6),
            ),
            ValueListenableBuilder(
              valueListenable: _bloc.loadBookMarks().listenable(),
              builder: (BuildContext context, value, Widget? child) {
                List items = _bloc.loadBookMarks().values.toList();
                items.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
                if (items.isEmpty){
                  return Text("no bookmarks yet");
                }
                return _BookmarkListWidget(items: items,);
              },
            )
          ],
        ),
      )
    );
  }

  Container _buildButton(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          onPressed: _onStartScan,
          child: Text("Start Scan", style: Theme.of(context).textTheme.headline5)
      ),
    );
  }

  void _onStartScan() {
    Navigator.push(context,
        MaterialPageRoute(
        builder: (context) => const QRCodeScannerView()));
  }
}


class _BookmarkListWidget extends StatelessWidget{

  final List items;

  const _BookmarkListWidget({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (_, index){
            return ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => QRCodeDetailView(idData: items[index]["timestamp"],)));
              },
              title: Text("${items[index]['data']}"),
            );
          },
          separatorBuilder: (_, __) => const Divider(color: Colors.blueGrey, height: 2,),
          itemCount: items.length
      ),
    );
  }

}
