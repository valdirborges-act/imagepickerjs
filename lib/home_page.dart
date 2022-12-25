import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  static const routeName = '/imagens';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ImagePicker imagePicker = ImagePicker();
  File? imagemSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imagens'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          imagemSelecionada == null
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.file(imagemSelecionada!),
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
}
