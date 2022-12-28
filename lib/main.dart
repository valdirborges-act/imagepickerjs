import 'package:flutter/material.dart';
import 'package:imagepicker/counterapp.dart';
import 'package:imagepicker/lmagemjs.dart';
import 'package:imagepicker/principal.dart';
import 'package:imagepicker/webviewjs.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Imagens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Principal(),
        HomePage.routeName: (context) => HomePage(),
        CounterApp.routeName: (context) => CounterApp(),
        WebViewJS.routeName: (context) => WebViewJS(title: 'WebView JavaScript',),
        ImagemJS.routeName: (context) => ImagemJS(),
      },
    );
  }
}
