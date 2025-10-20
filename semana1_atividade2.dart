import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semana 2',
      home:ContadorPage(),
    ); // Fecha MaterialApp
  } // Fecha o build
} // Fecha a classe


class ContadorPage extends StatefulWidget {
  const ContadorPage({super.key});

  @override
  _ContadorPageState createState() => _ContadorPageState();
} 

class _ContadorPageState extends State<ContadorPage> {
  int contador = 0;
  String nome = "";
  final TextEditingController _controller = TextEditingController();
  
  void incrementar(){
    setState(() {
      nome = _controller.text;
      contador ++;
    }
   );
  }
  
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Semana 2 - Contador")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller, 
              decoration: InputDecoration(labelText: "Digite seu nome"),
            ), // Fecha TextField
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: incrementar,
              child: Text('Clique aqui'),
            ), // Fecha ElevatedButton
            SizedBox(height: 20),
            Text(
              nome.isEmpty ? "Nenhum nome digitado" :
              '$nome, Você clicou $contador vezes',
              style: TextStyle(fontSize: 18)
            ), // Fecha Text
          ], // Fecha Children
        ), // Fecha Colum
      ), // Fecha Padding
    ); // Fecha Scaffold
  } // Fecha Build
}  // Fecha ContadorPageState