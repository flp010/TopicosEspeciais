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
      title: 'Postagens da API',
      home: PostsPage(),
    );
  }
}

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late Future<List> _futurePosts;
  String busca = '';

  Future<List> buscarPosts() async {
    try {
      final resposta = await HttpRequest.getString(
        'https://jsonplaceholder.typicode.com/posts',
      );
      final dados = json.decode(resposta);
      // Retorna apenas os 5 primeiros posts
      return dados.sublist(0, 5);
    } catch (e) {
      print('Erro ao buscar posts: $e');
      throw Exception('Falha ao carregar postagens');
    }
  }

  @override
  void initState() {
    super.initState();
    _futurePosts = buscarPosts();
  }

  void atualizarPosts() {
    setState(() {
      _futurePosts = buscarPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Postagens'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: atualizarPosts,
          ),
        ],
      ),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar por título...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (valor) {
                setState(() {
                  busca = valor.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List>(
              future: _futurePosts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar postagens.'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhuma postagem encontrada.'));
                }

            
                final postsFiltrados = snapshot.data!
                    .where((post) =>
                        post['title']
                            .toString()
                            .toLowerCase()
                            .contains(busca))
                    .toList();

                if (postsFiltrados.isEmpty) {
                  return Center(child: Text('Nenhuma postagem encontrada.'));
                }

                return ListView.builder(
                  itemCount: postsFiltrados.length,
                  itemBuilder: (context, index) {
                    final post = postsFiltrados[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(
                        title: Text(post['title']),
                        subtitle: Text(
                          post['body'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetalhesPage(post: post),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetalhesPage extends StatelessWidget {
  final Map post;

  DetalhesPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes da Postagem')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post['title'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(post['body'], style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
