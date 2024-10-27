import 'dart:ui_web';

import 'package:bsitest/markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'web_view.dart';

void main() {
  WebViewPlatform.instance = WebWebViewPlatform();
  runApp(const MaterialApp(home: MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var loadingPercentage = 0;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  bool istouch = false;

  List numberlist = [2, 4, 6, 5, 3, 1, 7, 9, 10, 8];

  List oddList = [];
  List tempList = [];
  void _oddOrEven() {
    for (final i in numberlist) {
      numberlist.remove(7);
      if (i.isOdd) {
        tempList.add(i);
      }
    }
    setState(() {
      istouch = true;
      tempList.sort((a, b) => b.compareTo(a));
      oddList.add(tempList);
    });
  }

  void _resetValue() {
    oddList.clear();
    tempList.clear();
    setState(() {
      istouch = false;
    });
  }

  final PlatformWebViewController _controller = PlatformWebViewController(
    const PlatformWebViewControllerCreationParams(),
  )..loadRequest(
      LoadRequestParams(
        uri: Uri.parse(
            'https://dartpad.dev/embed-inline.html?id=5d70bc1889d055c7a18d35d77874af88'),
      ),
    );

    String jwb1 = """void main() {
  List numberList = [2, 4, 6, 5, 3, 1, 7, 9, 10, 8];
  List list = [];
  for (final i in numberList) {
    numberList.remove(7);
    if (i.isOdd) {
      list.add(i);
    }
  }
  list.sort((a, b) => b.compareTo(a));
  print(list);
}""";

String jwb2 = """
void main() {
  String str = "aaabbcccaaaac";
  Map<String, int> map = {};

  for (int i = 0; i < str.length; i++) {
    int count = map[str[i]] ?? 0;
    map[str[i]] = count + 1;
  }
  print(map);
}
""";

String jwb3 = """

import 'dart:convert';

void main() {
  var data = [
    {"id": '1', "customer_id": '21', "transaction_date": '7/30/2019'},
    {"id": '2', "customer_id": '15', "transaction_date": '7/21/2019'},
    {"id": '3', "customer_id": '16', "transaction_date": '7/18/2019'},
    {"id": '4', "customer_id": '20', "transaction_date": '7/22/2019'},
    {"id": '5', "customer_id": '15', "transaction_date": '7/15/2019'},
    {"id": '6', "customer_id": '20', "transaction_date": '7/12/2019'},
    {"id": '7', "customer_id": '15', "transaction_date": '7/21/2019'},
    {"id": '8', "customer_id": '20', "transaction_date": '7/12/2019'},
  ];

  List result = data
      .fold({}, (previousValue, element) {
        Map val = previousValue;
        List raw = [];
        String date = element['customer_id']!;
        if (!val.containsKey(date)) {
          val[date] = [];
        }
        element.remove('customer_id');

        raw.add(element['transaction_date']);

        val[date]?.add(element['transaction_date']);
        return val;
      })
      .entries
      .map((e) => {'customer_id': e.key, 'total_penjualan': e.value.length})
      .toList();
  result.sort((a, b) => a['customer_id'].compareTo(b['customer_id']));

  print(json.encode(result));
}
 """;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text('BSI Technical Test - Assignment For Aditya Hermanto'),
            Text('jawaban dapat langsung dicoba dengan copy kode pada soal'),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child:   ListView(
                children:  [
                  ExpansionTile(title: const Text('Soal 1'), children: [
                  Image.asset('assets/images/soal 1.png', height: 200,),
                   MarkdownPage(jwb1),
                 ],),
                  ExpansionTile(title: const Text('Soal 2'), children: [
                  Image.asset('assets/images/soal 2.png', height: 200,),
                   MarkdownPage(jwb2),
                 ],),
                  ExpansionTile(title: const Text('Soal 3'), children: [
                  Image.asset('assets/images/soal 3.png', height: 400,),
                   MarkdownPage(jwb3),
                 ],),
                  
                 
                 
                ],
              ),
            ),
            const Expanded(
                child: IframeView(
                    source:
                        "https://dartpad.dev/embed-inline.html?id=5d70bc1889d055c7a18d35d77874af88")),
          ],
        ),
      ),
      
    );
  }
}
