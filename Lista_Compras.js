import { SafeAreaView, Text, View, TextInput, TouchableOpacity, FlatList, StyleSheet } from 'react-native'
import { useState } from 'react'

export default function App() {
    const [compra, setCompra] = useState("")
    const [compras, setCompras] = useState([])
    const [quantidade, setQuantidade] = useState("")

    const adicionarCompra = () => {
        if (compra.trim() === "" || compra != Number) {
            alert("Dados inseridos não pode ser um número ou espaço em branco")
            return
        }

        if (quantidade.trim() === "" || isNaN(Number(quantidade)) || Number(quantidade) <= 0) {
            alert("Quantidade deve ser um número maior que 0")
            return
        }

        const nova = {
            id: Date.now().toString(),
            titulo: compra,
            quantidade: Number(quantidade)
        }

        setCompras([...compras, nova])
        setCompra("")
        setQuantidade("")
    }

    const removerCompra = (id) => {
        setCompras(compras.filter((item) => item.id !== id))
    }

    const apagarLista = () => {
        setCompras([])
    }

    const renderItem = ({ item }) => {
        const isPar = item.quantidade % 2 === 0
        return (
            <View style={[
                styles.item,
                { backgroundColor: isPar ? "#d1fae5" : "#fee2e2" }
            ]}>
                <Text style={{ color: "#1f2937" }}>
                    {item.titulo} - {item.quantidade}
                </Text>
                <TouchableOpacity onPress={() => removerCompra(item.id)} style={styles.botaoRemover}>
                    <Text style={{ color: "#1f2937",fontWeight: 'bold' }}>X</Text>
                </TouchableOpacity>
            </View>
        )
    }

    return (
        <SafeAreaView style={styles.container}>
            <Text style={styles.titulo}>Lista de compras</Text>

            <View style={styles.areaInput}>
                <TextInput
                    style={styles.input}
                    placeholder="Digite um item de compra"
                    value={compra}
                    onChangeText={setCompra}
                />
                <TextInput
                    style={styles.input}
                    placeholder="Digite a quantidade"
                    value={quantidade}
                    onChangeText={setQuantidade}
                    keyboardType="numeric"
                />
                <TouchableOpacity style={styles.botaoAdd} onPress={adicionarCompra}>
                    <Text style={{ color: "#1f2937" }}>Adicionar</Text>
                </TouchableOpacity>
            </View>

            <FlatList
                data={compras}
                keyExtractor={(item) => item.id}
                renderItem={renderItem}
                contentContainerStyle={{ paddingBottom: 100 }}
                ListEmptyComponent={<Text style={{ marginTop: 20 }}>Nenhum item adicionado ainda</Text>}
            />

            {compras.length > 0 && (
                <TouchableOpacity style={styles.botaoApagarLista} onPress={apagarLista}>
                    <Text style={{ color: "#1f2937" }}>Apagar lista</Text>
                </TouchableOpacity>
            )}
        </SafeAreaView>
    )
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        padding: 20,
        paddingBottom: 100,
        backgroundColor: "#f0f4f8",
    },
    titulo: {
        fontSize: 24,
        marginBottom: 20,
        textAlign: "center"
    },
    areaInput: {
        flexDirection: "column",
        marginBottom: 20,
    },
    input: {
        paddingHorizontal: 12,
        backgroundColor: "#ffffff",
        marginBottom: 10,
        borderRadius: 6,
        height: 40
    },
    botaoAdd: {
        backgroundColor: "#10b981",
        alignItems: "center",
        borderRadius: 6,
        justifyContent: "center",
        padding: 10
    },
    item: {
        flexDirection: "row",
        justifyContent: "space-between",
        padding: 12,
        marginBottom: 8,
        borderRadius: 8
    },
    botaoRemover: {
        borderRadius: 6,
        paddingHorizontal: 10,
        justifyContent: "center"
    },
    botaoApagarLista: {
        position: 'absolute',
        bottom: 20,
        left: 20,
        right: 20,
        backgroundColor: "#ef4444",
        borderRadius: 6,
        justifyContent: "center",
        alignItems: "center",
        padding: 12
    }
})
