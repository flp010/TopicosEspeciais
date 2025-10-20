import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Compras',
      theme: ThemeData(primarySwatch: Colors.green),
      home: ListaComprasPage(),
    );
  }
}

class ListaComprasPage extends StatefulWidget {
  @override
  _ListaComprasPageState createState() => _ListaComprasPageState();
}

class _ListaComprasPageState extends State<ListaComprasPage> {
  final TextEditingController _produtoController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();

  final List<Map<String, dynamic>> _itens = [];

  void adicionarItem() {
    String produto = _produtoController.text.trim();
    String quantidade = _quantidadeController.text.trim();

    if (produto.isNotEmpty && quantidade.isNotEmpty) {
      setState(() {
        _itens.add({
          "produto": produto,
          "quantidade": quantidade,
        });
        _produtoController.clear();
        _quantidadeController.clear();
      });
    }
  }

  void removerItem(int index) {
    setState(() {
      _itens.removeAt(index);
    });
  }

  void limparLista() {
    setState(() {
      _itens.clear();
    });
  }

  String getEmojiProduto(String produto) {
    if (produto.toLowerCase().contains("pão")) return "🥖";
    if (produto.toLowerCase().contains("suco")) return "🧃";
    if (produto.toLowerCase().contains("carne")) return "🍖";
    if (produto.toLowerCase().contains("papel")) return "🧻";
    return "🛒"; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("🛒 Lista de Compras"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: limparLista,
            tooltip: "Limpar lista",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [ 
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _produtoController,
                    decoration: InputDecoration(
                      labelText: "Produto",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 80,
                  child: TextField(
                    controller: _quantidadeController,
                    decoration: InputDecoration(
                      labelText: "Qtd",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: adicionarItem,
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20),
            
            Expanded(
              child: _itens.isEmpty
                  ? Center(
                      child: Text(
                        "Nenhum item na lista de compras.",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _itens.length,
                      itemBuilder: (context, index) {
                        final item = _itens[index];
                        return Card(
                       
                          color: index % 2 == 0
                              ? Colors.green.shade100
                              : Colors.grey.shade200,
                          child: ListTile(
                            leading: Text(
                              getEmojiProduto(item["produto"]),
                              style: TextStyle(fontSize: 28),
                            ),
                            title: Text(item["produto"],
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text("Quantidade: ${item["quantidade"]}"),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => removerItem(index),
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
