import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Trabalho 1",
      home: const DadosPage(),
    );
  }
}

class DadosPage extends StatefulWidget {
  const DadosPage({super.key});

  @override
  State<DadosPage> createState() => _DadosPageState();
}

class _DadosPageState extends State<DadosPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();

  String mensagem = "";
  IconData? icone;
  Color corFundo = Colors.white;

  void mostrarDados() {
    String nome = _nomeController.text;
    int? idade = int.tryParse(_idadeController.text);

    if (nome.isEmpty || idade == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha os campos corretamente!")),
      );
      return;
    }

    setState(() {
      mensagem = "Olá, $nome! Você tem $idade anos.";

      if (idade < 12) {
        icone = Icons.child_care;
        corFundo = Colors.lightBlue.shade100;
      } else if (idade >= 12 && idade <= 21) {
        icone = Icons.school;
        corFundo = Colors.green.shade100;
      } else if (idade >= 22 && idade <= 60) {
        icone = Icons.work;
        corFundo = Colors.orange.shade100;
      } else {
        icone = Icons.elderly;
        corFundo = Colors.grey.shade400;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Dados de $nome exibidos!")),
    );
  }

  void limpar() {
    setState(() {
      _nomeController.clear();
      _idadeController.clear();
      mensagem = "";
      icone = null;
      corFundo = Colors.white;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Campos limpos!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      appBar: AppBar(
        title: const Text("Trabalho 1"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: "Digite seu nome"),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Digite sua idade"),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: mostrarDados,
                    child: const Text("Mostrar dados"),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: limpar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text("Limpar"),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                mensagem,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              if (icone != null) Icon(icone, size: 50, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}
