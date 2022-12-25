import 'package:flutter/material.dart';

class Principal extends StatelessWidget {
  Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Interações'),
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: ElevatedButton(
                    child: Text('Imagens'),
                    onPressed: () {
                      print('Clicou no botão');

                      Navigator.pushNamed(context, '/imagens');
                    },
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    child: Text('Contador'),
                    onPressed: () {
                      print('Clicou no botão');

                      Navigator.pushNamed(context, '/contador');
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
