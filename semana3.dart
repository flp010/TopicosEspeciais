import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
// App principal


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semana 3',
      home: ListaTarefasPage(),
    );
  }
}
// Classe que contém a lista dinâmica
class ListaTarefasPage extends StatefulWidget {
  @override
  _ListaTarefasPage createState() => _ListaTarefasPageState();
  final TextEditingController _controller = TextEditingController();
  final List<String> _tarefas = [];
}
 
  void adicionarTarefa() {
    String texto = _controller.text.trim();
    if (texto.isNotEmpty) {
      setState(() {
        _tarefas.add(texto);
        _controller.clear();
      }); // Fecha setState
    } //fecha if
  } // Fecha adicionarTarefa

void removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    }); // Fecha setState
  } // Fecha removerTarefa
class _ListaTarefasPageState extends State<ListaTarefasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Semana 3 Lista de Tarefas')),
      body: Padding(
        padding: const EdgeInsets.all (16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Digite uma tarefa',
                sufixeIcon: IconButton(
                  icon: Icon(icons.add),
                  onPressed: adicionarTarefa,
                )// Fecha IconButton
              ),// Fecha InputDecoration
              onSubmitted: () => adicionarTarefa(),
            ) // Fecha TextField
            SizedBox(height: 20),
            expanded(
              child: _tarefas.isEmpty 
                ? center(
                    child: Text('Nenhuma tarefa adicionada',
                    style: TextStyle(color: Colors.grey),
                    ),// Fecha Text
              )// fecha Center
                : ListView.builder(
                    itemCount: _tarefas.length,
                    itemBuilder: (context, index) {
                      return Card (
                        child: ListTitle(
                          title: Text(_tarefas[index]),
                          tralling: IconButton(
                            icon: Icon(Icons.delete, colors.red),
                            onPressed: () => removerTarefa(index)
                          ),
                        ),
                      );
                    }, // Fecha itemBuilder
                  ), // Fecha ListView
            ),// fecha Expanded
          ], // Fecha children
        ), // Fecha Column
      ), // Fecha Padding
    ); // Fecha Scaffold 
  } // Fecha build
}// Fecha Classe
/* --------------------------------------------------------------------------------------------- */
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// App principal
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semana 3',
      home: ListaTarefasPage(),
    );
  }
}

// Classe que contém a lista dinâmica
class ListaTarefasPage extends StatefulWidget {
  @override
  _ListaTarefasPageState createState() => _ListaTarefasPageState();
}

class _ListaTarefasPageState extends State<ListaTarefasPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _tarefas = [];

  void adicionarTarefa() {
    String texto = _controller.text.trim();
    if (texto.isNotEmpty) {
      setState(() {
        _tarefas.add(texto);
        _controller.clear();
      });
    }
  }

  void removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Semana 3 - Lista de Tarefas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Digite uma tarefa',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: adicionarTarefa,
                ),
              ),
              onSubmitted: (value) => adicionarTarefa(),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _tarefas.isEmpty
                  ? Center(
                      child: Text(
                        'Nenhuma tarefa adicionada',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _tarefas.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(_tarefas[index]),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => removerTarefa(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

