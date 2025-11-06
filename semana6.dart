import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:html';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Semana 6 - API (CORS liberado)',
      home: UsuariosPage(),
    );
  }
}

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  List usuarios = [];
  bool carregando = true;

  Future<void> buscarUsuarios() async {
    try {
      final resposta = await HttpRequest.getString(
        'https://jsonplaceholder.typicode.com/users',
      );
      final dados = json.decode(resposta); // converte string p/ json
      setState(() {
        usuarios = dados;
        carregando = false;
      });
    } catch (e) {
      print('Erro: $e');
      setState(() {
        carregando = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    buscarUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Usuários da API JsonPlaceHolder")),
      body: carregando
            ? Center(child: CircularProgressIndicator())
            : usuarios.isEmpty
              ? Center(child: Text("Nenhum usuário encontrado"))
              : ListView.builder(
                itemCount: usuarios.length,
                itemBuilder: (context, index){
                  final user = usuarios[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Text(user["name"][0])),
                      title: Text(user["name"]),
                      subtitle: Text(user["email"]),
                    ),
                  );
                },
              ),
    );
  }
}
