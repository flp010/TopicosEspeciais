import { SafeAreaView, Text, View, TextInput, TouchableOpacity, FlatList, StyleSheet } from 'react-native'
import { useState, useEffect } from 'react'
import AsyncStorage from '@react-native-async-storage/async-storage'

const STORAGE_KEY = "@lista_filmes"

export default function App() {
  const [filme, setFilme] = useState("")
  const [ano, setAno] = useState("")
  const [filmes, setFilmes] = useState([])

  const adicionarFilme = () => {
    if (filme.trim() === "" || !isNaN(Number(filme))) {
      alert("O nome do filme não pode ser um número ou espaço em branco")
      return
    }

    if (ano.trim() === "" || isNaN(Number(ano)) || Number(ano) < 1888 || Number(ano) > new Date().getFullYear()) {
      alert("Digite um ano válido")
      return
    }

    const novo = {
      id: Date.now().toString(),
      nome: filme,
      ano: Number(ano),
      favorito: false
    }

    setFilmes([...filmes, novo])
    setFilme("")
    setAno("")
  }

  const removerFilme = (id) => {
    setFilmes(filmes.filter((item) => item.id !== id))
  }

  const limparLista = () => {
    setFilmes([])
  }

  const toggleFavorito = (id) => {
    setFilmes(
      filmes.map((f) => f.id === id ? { ...f, favorito: !f.favorito } : f)
    )
  }

  const renderItem = ({ item }) => (
    <View style={styles.item}>
      <TouchableOpacity onPress={() => toggleFavorito(item.id)}>
        <Text style={styles.favorito}>{item.favorito ? "⭐" : "☆"}</Text>
      </TouchableOpacity>
      <Text style={[styles.textoFilme, item.favorito && styles.textoFavorito]}>
        {item.nome} ({item.ano})
      </Text>
      <TouchableOpacity onPress={() => removerFilme(item.id)}>
        <Text style={styles.remover}>❌</Text>
      </TouchableOpacity>
    </View>
  )

  useEffect(() => {
    (async () => {
      try {
        const salvo = await AsyncStorage.getItem(STORAGE_KEY)
        if (salvo) setFilmes(JSON.parse(salvo))
      } catch (e) {
        console.log("Erro ao carregar filmes")
      }
    })()
  }, [])

  useEffect(() => {
    (async () => {
      try {
        await AsyncStorage.setItem(STORAGE_KEY, JSON.stringify(filmes))
      } catch (e) {
        console.log("Erro ao salvar filmes")
      }
    })()
  }, [filmes])

  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.titulo}>Lista de Filmes Assistidos</Text>

      <View style={styles.areaInput}>
        <TextInput
          style={styles.input}
          placeholder="Nome do filme..."
          value={filme}
          onChangeText={setFilme}
        />
        <TextInput
          style={styles.inputAno}
          placeholder="Ano"
          value={ano}
          onChangeText={setAno}
          keyboardType="numeric"
        />
        <TouchableOpacity style={styles.botaoAdd} onPress={adicionarFilme}>
          <Text style={{ fontWeight: "bold", color: "#1f2937" }}>Adicionar</Text>
        </TouchableOpacity>
      </View>

      <FlatList
        data={filmes}
        keyExtractor={(item) => item.id}
        renderItem={renderItem}
        ListEmptyComponent={<Text style={styles.vazio}>Nenhum filme cadastrado ainda.</Text>}
        contentContainerStyle={{ paddingBottom: 100 }}
      />

      {filmes.length > 0 && (
        <TouchableOpacity style={styles.botaoLimpar} onPress={limparLista}>
          <Text style={{ fontWeight: "bold", color: "#1f2937" }}>Limpar tudo</Text>
        </TouchableOpacity>
      )}
    </SafeAreaView>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: "#d8e9eede"
  },
  titulo: {
    fontSize: 24,
    fontWeight: "bold",
    textAlign: "center",
    marginBottom: 15
  },
  areaInput: {
    flexDirection: "column",
    marginBottom: 20
  },
  input: {
    backgroundColor: "#fff",
    padding: 10,
    borderRadius: 6,
    marginBottom: 10,
    width: 300
  },
  inputAno: {
    backgroundColor: "#fff",
    padding: 10,
    borderRadius: 6,
    marginBottom: 10,
    width: 300
  },
  botaoAdd: {
    backgroundColor: "#10b981",
    padding: 10,
    borderRadius: 6,
    alignItems: "center",
    marginBottom: 10
  },
  item: {
    flexDirection: "row",
    alignItems: "center",
    padding: 10,
    marginBottom: 8,
    borderRadius: 6,
    backgroundColor: "#fff",
    justifyContent: "space-between"
  },
  favorito: {
    fontSize: 20,
    marginRight: 10
  },
  textoFilme: {
    flex: 1,
    fontSize: 16
  },
  textoFavorito: {
    fontWeight: "bold",
    color: "#eab308"
  },
  remover: {
    fontSize: 18,
    color: "red",
    fontWeight: "bold"
  },
  vazio: {
    textAlign: "center",
    marginTop: 20,
    fontStyle: "italic"
  },
  botaoLimpar: {
    position: "absolute",
    bottom: 20,
    left: 20,
    right: 20,
    backgroundColor: "#ef4444",
    padding: 12,
    borderRadius: 6,
    alignItems: "center"
  }
})
