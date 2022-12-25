import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';

class CounterApp extends StatelessWidget {
  CounterApp({super.key});
  static const routeName = '/contador';

  final JavascriptRuntime jsRuntime = getJavascriptRuntime();
  final number = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: ValueListenableBuilder(
              valueListenable: number,
              builder: (_, value, __) {
                return Text(
                  value.toString(),
                  style: Theme.of(context).textTheme.headline2,
                );
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
        onPressed: () async {
          try {
            final result = await addFromJs(jsRuntime, number.value, 1);
            number.value = result;
          } on PlatformException catch (e) {
            print('error: ${e.details}');
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

Future<int> addFromJs(
  JavascriptRuntime jsRuntime,
  int primeiroNumero,
  int segundoNumero,
) async {
  String blocJs = await rootBundle.loadString("assets/bloc.js");
  final jsResult =
      jsRuntime.evaluate(blocJs + """soma($primeiroNumero, $segundoNumero)""");

  final jsStringResult = jsResult.stringResult;
  return int.parse(jsStringResult);
}
