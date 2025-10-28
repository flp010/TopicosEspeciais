import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Tela1(),
    );
  }
}
class Tela1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem-vindo ao App de Cadastro"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.blue[50],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_people, size: 100, color: Colors.blue),
              SizedBox(height: 20),
              Text(
                "Bem-vindo ao App de Cadastro 👋",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text("Iniciar Cadastro", style: TextStyle(fontSize: 18)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Tela2()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tela2 extends StatefulWidget {
  @override
  _Tela2State createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário de Cadastro"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.green[50],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.edit, size: 80, color: Colors.green),
              SizedBox(height: 20),
              TextField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: idadeController,
                decoration: InputDecoration(
                  labelText: "Idade",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "E-mail",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),
              TextField(
                controller: telefoneController,
                decoration: InputDecoration(
                  labelText: "Telefone",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text("Próximo", style: TextStyle(fontSize: 18)),
                onPressed: () {
                  String nome = nomeController.text.trim();
                  String idade = idadeController.text.trim();
                  String email = emailController.text.trim();
                  String telefone = telefoneController.text.trim();

                  if (nome.isNotEmpty && idade.isNotEmpty && email.isNotEmpty && telefone.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Tela3(
                          nome: nome,
                          idade: idade,
                          email: email,
                          telefone: telefone,
                        ),
                      ),
                    ).then((result) {
                      if (result != null && result is Map<String, String>) {
                        setState(() {
                          nomeController.text = result['nome'] ?? '';
                          idadeController.text = result['idade'] ?? '';
                          emailController.text = result['email'] ?? '';
                          telefoneController.text = result['telefone'] ?? '';
                        });
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Por favor, preencha todos os campos.")),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tela3 extends StatelessWidget {
  final String nome;
  final String idade;
  final String email;
  final String telefone;

  Tela3({
    required this.nome,
    required this.idade,
    required this.email,
    required this.telefone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resumo do Cadastro"),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        color: Colors.purple[50],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, size: 100, color: Colors.purple),
                SizedBox(height: 20),
                Text(
                  "Resumo do Cadastro",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple[900]),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nome: $nome", style: TextStyle(fontSize: 18)),
                        SizedBox(height: 10),
                        Text("Idade: $idade", style: TextStyle(fontSize: 18)),
                        SizedBox(height: 10),
                        Text("E-mail: $email", style: TextStyle(fontSize: 18)),
                        SizedBox(height: 10),
                        Text("Telefone: $telefone", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                      child: Text("Editar", style: TextStyle(fontSize: 18)),
                      onPressed: () {
                        Navigator.pop(context, {
                          'nome': nome,
                          'idade': idade,
                          'email': email,
                          'telefone': telefone,
                        });
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                      child: Text("Finalizar", style: TextStyle(fontSize: 18)),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Cadastro finalizado com sucesso!")),
                        );
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
