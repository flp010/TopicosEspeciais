import { NavigationContainer } from "@react-navigation/native"
import { createStackNavigator } from "@react-navigation/stack"
import { SafeAreaView, Text, View, TextInput, TouchableOpacity, StyleSheet, } from "react-native"
import { useState } from "react"

const Stack = createStackNavigator()

export default function App() {
    const [formData, setFormData] = useState({
        nome: "",
        email: "",
        telefone: "",
        idade: "",
    })

    const limparFormulario = () => {
        setFormData({ nome: "", email: "", telefone: "", idade: "" })
    }

    return (
        <NavigationContainer>
            <Stack.Navigator initialRouteName="Inicio">
                <Stack.Screen name="Inicio" options={{ title: "Início" }}>
                    {(props) => (
                        <InitialScreen {...props} limparFormulario={limparFormulario} />
                    )}
                </Stack.Screen>
                <Stack.Screen name="Formulário" options={{ title: "Cadastro" }}>
                    {(props) => (
                        <FormScreen
                            {...props}
                            formData={formData}
                            setFormData={setFormData}
                        />
                    )}
                </Stack.Screen>
                <Stack.Screen name="Confirmação" options={{ title: "Confirmação" }}>
                    {(props) => <ConfirmScreen {...props} setFormData={setFormData} />}
                </Stack.Screen>
                <Stack.Screen name="Resumo" options={{ title: "Resumo" }}>
                    {(props) => <ResumoScreen {...props} />}
                </Stack.Screen>
            </Stack.Navigator>
        </NavigationContainer>
    )
}

function InitialScreen({ navigation, limparFormulario }) {
    return (
        <SafeAreaView style={styles.container}>
            <Text style={styles.titulo}>Bem-vindo!!!</Text>
            <TouchableOpacity
                style={styles.botao}
                onPress={() => navigation.navigate("Formulário")}
            >
                <Text style={styles.botaoTexto}>Ir para Cadastro</Text>
            </TouchableOpacity>

            <TouchableOpacity
                style={[styles.botao, styles.botaoLimpar]}
                onPress={limparFormulario}
            >
                <Text style={styles.botaoTexto}>Limpar Formulário</Text>
            </TouchableOpacity>
        </SafeAreaView>
    )
}

function FormScreen({ navigation, formData, setFormData }) {
    const enviar = () => {
        const { nome, email, telefone, idade } = formData
        if (!nome.trim() || !email.trim() || !telefone.trim() || !idade.trim()) {
            alert("Preencha todos os campos")
            return
        }
        navigation.navigate("Confirmação", { ...formData })
    }

    return (
        <SafeAreaView style={styles.container}>
            <Text style={styles.titulo}>Preencha seus dados</Text>

            <TextInput
                style={styles.input}
                placeholder="Nome"
                value={formData.nome}
                onChangeText={(t) => setFormData({ ...formData, nome: t })}
            />
            <TextInput
                style={styles.input}
                placeholder="E-mail"
                keyboardType="email-address"
                value={formData.email}
                onChangeText={(t) => setFormData({ ...formData, email: t })}
            />
            <TextInput
                style={styles.input}
                placeholder="Telefone"
                keyboardType="phone-pad"
                value={formData.telefone}
                onChangeText={(t) => setFormData({ ...formData, telefone: t })}
            />
            <TextInput
                style={styles.input}
                placeholder="Idade"
                keyboardType="numeric"
                value={formData.idade}
                onChangeText={(t) => setFormData({ ...formData, idade: t })}
            />

            <TouchableOpacity style={styles.botao} onPress={enviar}>
                <Text style={styles.botaoTexto}>Enviar</Text>
            </TouchableOpacity>
        </SafeAreaView>
    )
}

function ConfirmScreen({ route, navigation }) {
    const { nome, email, telefone, idade } = route.params

    return (
        <SafeAreaView style={styles.container}>
            <Text style={styles.titulo}>Confirme seus dados</Text>

            <Text style={styles.dado}>Nome: {nome}</Text>
            <Text style={styles.dado}>E-mail: {email}</Text>
            <Text style={styles.dado}>Telefone: {telefone}</Text>
            <Text style={styles.dado}>Idade: {idade}</Text>

            <TouchableOpacity
                style={styles.botao}
                onPress={() => navigation.navigate("Formulário")}
            >
                <Text style={styles.botaoTexto}>Editar dados</Text>
            </TouchableOpacity>

            <TouchableOpacity
                style={styles.botao}
                onPress={() => navigation.navigate("Resumo", route.params)}
            >
                <Text style={styles.botaoTexto}>Ir para Resumo</Text>
            </TouchableOpacity>
        </SafeAreaView>
    )
}

function ResumoScreen({ route, navigation }) {
    const { nome, email, telefone, idade } = route.params

    return (
        <SafeAreaView style={styles.container}>
            <View style={styles.card}>
                <Text style={styles.cardText}>👤 Nome: {nome}</Text>
                <Text style={styles.cardText}>📧 E-mail: {email}</Text>
                <Text style={styles.cardText}>📱 Telefone: {telefone}</Text>
                <Text style={styles.cardText}>🎂 Idade: {idade}</Text>
            </View>

            <TouchableOpacity
                style={styles.botao}
                onPress={() => navigation.navigate("Inicio")}
            >
                <Text style={styles.botaoTexto}>Voltar para Início</Text>
            </TouchableOpacity>
        </SafeAreaView>
    )
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: "center",
        justifyContent: "center",
        padding: 20,
        backgroundColor: "#f2f2f2",
    },
    titulo: {
        fontSize: 22,
        textAlign: "center",
        fontWeight: "bold",
        marginBottom: 20,
    },
    input: {
        height: 50,
        borderRadius: 8,
        borderWidth: 1,
        borderColor: "#ccc",
        paddingHorizontal: 10,
        backgroundColor: "#fff",
        marginBottom: 10,
    },
    botao: {
        backgroundColor: "#003366",
        padding: 15,
        borderRadius: 8,
        marginVertical: 5,
        width: "100%",
    },
    botaoLimpar: {
        backgroundColor: "#cc0000",
    },
    botaoTexto: {
        color: "#fff",
        textAlign: "center",
        fontWeight: "bold",
    },
    dado: {
        fontSize: 16,
        marginBottom: 10,
    },
    card: {
        padding: 20,
        borderRadius: 10,
        backgroundColor: "#fff",
        marginBottom: 20,
        elevation: 3,
    },
    cardText: {
        fontSize: 16,
        marginVertical: 5,
    },
})
