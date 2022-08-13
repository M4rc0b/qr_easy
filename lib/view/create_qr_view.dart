import 'package:flutter/material.dart';
import 'package:qreasy/view/url_form_view.dart';
import 'package:qreasy/view/wifi_form_view.dart';
import 'package:qreasy/widgets/my_app_bar.dart';

import '../utils/styles.dart';

class CreateQrView extends StatefulWidget {
  const CreateQrView({Key? key}) : super(key: key);

  @override
  State<CreateQrView> createState() => _CreateQrViewState();
}

class _CreateQrViewState extends State<CreateQrView>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: 'Create QR Code',
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              TabBar(
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Styles.black),
                controller: _controller,
                tabs: <Tab>[
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black, width: 1)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("URL"),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black, width: 1)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Wifi"),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: const [
                    UrlFormView(),
                    WifiFormView(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
