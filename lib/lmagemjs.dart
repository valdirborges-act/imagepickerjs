import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:flutter/services.dart';

class ImagemJS extends StatefulWidget {
  static const routeName = '/imagemjs';
  const ImagemJS({super.key});

  @override
  State<ImagemJS> createState() => _ImagemJSState();
}

class _ImagemJSState extends State<ImagemJS> {
  late WebViewPlusController? _controller;
  ImagePicker imagePicker = ImagePicker();
  File? imagemSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ImagemJS'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          imagemSelecionada == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: 200.0,
                    child: Image.file(imagemSelecionada!),
                  ),
                ),
                
          Container(
            height: 200.0,
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

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  pegarImagemGaleria();
                },
                icon: Icon(Icons.add_photo_alternate_outlined),
              ),
              IconButton(
                onPressed: () {
                  pegarImagemCamera();
                },
                icon: Icon(Icons.photo_camera_outlined),
              ),
              IconButton(
                onPressed: () {
                  // final _random = new Random();

                  // int next(int min, int max) => min + _random.nextInt(max - min);

                  // int randomico = next(0,1000);

                  // _controller!.webViewController.runJavascript('fromFlutter("$randomico")');

                  //File? imagemSelecionada;

                  List<int> imageBytes = imagemSelecionada!.readAsBytesSync();
                  print(imageBytes);
                  String base64Image = base64Encode(imageBytes);
                  _controller!.webViewController.runJavascript('fromFlutter("$base64Image")');
                },
                icon: Icon(Icons.javascript),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.backspace),
        label: const Text('Volta'),
        backgroundColor: Colors.indigoAccent,
      ),
    );
  }

  pegarImagemGaleria() async {
    final XFile? imagemTemporaria =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (imagemTemporaria != null) {
      setState(() {
        imagemSelecionada = File(imagemTemporaria.path);
      });
    }
  }

  pegarImagemCamera() async {
    final XFile? imagemTemporaria =
        await imagePicker.pickImage(source: ImageSource.camera);

    if (imagemTemporaria != null) {
      setState(() {
        imagemSelecionada = File(imagemTemporaria.path);
      });
    }
  }

  _loadHtmlFromAssets() async {
    String file = await rootBundle.loadString('assets/index.html');
    _controller!.loadUrl(Uri.dataFromString(
        file,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')).toString());
  }  
}
