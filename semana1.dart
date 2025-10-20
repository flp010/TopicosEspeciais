import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Semana 1 - Olá Flutter'),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Olá Flutter!!!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height : 20),
              Text(
                'Primeiro aplicativo no DartPad',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey
                ),
              ),
              SizedBox(height: 20),
              Icon(Icons.favorite, color: Colors.red, size: 48)
            ],
          ),
        ),
      ),
    );
  }
}
