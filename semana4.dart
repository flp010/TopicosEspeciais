import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semana 4 - armazenamento',
      home: ListaNotasPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class ListaNotasPage extends StatefulWidget {
@override
  _ListaNotasPageState createState() => _ListaNotasPageState();
}
class _ListaNotasPageState extends State<ListaNotasPage> {
  List<String> _notas = [];
  List<String> _armazenamentoSimulado = [];
  final TextEditingController _controller = TextEditingController();
  
  void carregarNotas(){
    setState(() {
      _notas= List.from(_armazenamentoSimulado);
    });
  }
  
  void adicionarNota(){
    String texto = _controller.text.trim();
    if (texto.isNotEmpty){
      setState((){
        _notas.add(texto);
        _armazenamentoSimulado = List.from(_notas); // Simula salvar em disco
        _controller.clear();
      }); // Fecha setState
    } // Fecha if
  } // Fecha adicionarNota
  
  void removerNota(int index){
    setState((){
      _notas.removeAt(index);
      _armazenamentoSimulado = List.from(_notas);
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar (
        title: Text ("Semana 4 - Notas Salvas"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            tooltip: "Carregar notas",
            onPressed: carregarNotas,
          ),// Fecha iconButton
        ], // Fecha actions
      ),// Fecha appBar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children : [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                               labelText: "Digite uma nota",
                               suffixIcon: IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: adicionarNota
                               )
             ), // Fecha InputDecoration
            onSubmitted: (_) => adicionarNota(),
            ), // Fecha TextField
            SizedBox(height: 20),
            Expanded(
              child: _notas.isEmpty ? Center(
                                         child: Text(
                                          "Nenhuma nota salva ainda",
                                           style: TextStyle(color:Colors.grey)
                                         ), // Fecha Text
              ) // Fecha Center 
              :
              ListView.builder(
                itemCount: _notas.length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      title: Text(_notas[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removerNota(index),
                      ), // Fecha IconButton
                    ), // Fecha ListTile
                  ); // Fecha Card 
                } // Fecha itemBuilder
              ) // ListView
            ), // Fecha Expanded
          ], // Fecha Children
        ),// Fecha Child
      ),// Fecha Padding
    );// Fecha Return   
  }// Fecha Build
}// Fecha Classe
