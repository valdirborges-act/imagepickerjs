import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class WebViewJS extends StatefulWidget {
  const WebViewJS({super.key, required this.title});
  static const routeName = '/webviewjs';

  final String title;

  @override
  State<WebViewJS> createState() => _WebViewJSState();
}

class _WebViewJSState extends State<WebViewJS> {
  late WebViewPlusController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Webview')),

      body: Column(
        children: [
          Container(
            height: 500.0,
            child: WebViewPlus(
              initialUrl: 'about:blank',
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: {
                JavascriptChannel(
                    name: 'messageHandler',
                    onMessageReceived: (JavascriptMessage message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(message.message)
                        )
                       );
                    })
              },
              onWebViewCreated: (controller) {
                _controller = controller;
                _loadHtmlFromAssets();
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text('Voltar'),
              onPressed: () {
                print('Clicou no botão');

                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_upward),
        onPressed: () {
          final _random = new Random();

          int next(int min, int max) => min + _random.nextInt(max - min);

          int randomico = next(0,1000);

          //_controller!.webViewController.runJavascript('fromFlutter("From Flutter")');
          _controller!.webViewController.runJavascript('fromFlutter("$randomico")');
        },
      ),
    );
  }

  _loadHtmlFromAssets() async {
    String file = await rootBundle.loadString('assets/index.html');
    _controller!.loadUrl(Uri.dataFromString(
        file,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')).toString());
  }  

}

