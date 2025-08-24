import { useState } from "react";
import { SafeAreaView, StyleSheet, Text, View, TextInput, TouchableOpacity } from 'react-native'

export default function App() {

    const [peso, setPeso] = useState("")
    const [altura, setAltura] = useState("")
    const [mensagem, setMensagem] = useState("")
    const calcularImc = () => {
        if (!peso || !altura) {
            alert("Digite um valor válido")
            return
        }
        const imc = peso / (altura * altura)
        let classificacao = ""

        if (imc < 18.5)
            classificacao = "Magreza extrema! Parece que você some se virar de lado 😬, saco de ossos ambulante!";
        else if (imc < 25)
            classificacao = "Peso normal... parabéns! Mas ainda parece que você está se enganando na balança 😏";
        else if (imc < 30)
            classificacao = "Sobrepeso! Alerta: a geladeira está te amando demais 🥴";
        else if (imc < 35)
            classificacao = "Obesidade grau 1! Seus amigos estão escondendo os doces pra você passar na porta 😂";
        else if (imc < 40)
            classificacao = "Obesidade grau 2! A balança entrou em greve e seu sofá já tem seu molde 🆘";
        else
            classificacao = "Obesidade grau 3! Você participa do programa quilos mortais e cada vez que você sobe na balança o Dr. Now chora 😵";
        
        setMensagem(`Seu IMC é ${imc.toFixed(2)} ${classificacao}`)
    }


    return (
        <SafeAreaView style={styles.container}>
            <Text style={styles.titulo}>Bem-vindo a calculadora IMC honesta </Text>
            <TextInput
                style={styles.input}
                value={peso}
                placeholder="Digite seu peso em kg"
                keyboardType="numeric"
                onChangeText={setPeso}
            />
            <TextInput
                style={styles.input}
                value={altura}
                placeholder="Digite sua altura em metros"
                keybordType="numeric"
                onChangeText={setAltura}
            />
            <TouchableOpacity onPress={calcularImc}
                style={styles.botao}>
                <Text> Calcular IMC</Text>
            </TouchableOpacity>
            <View>
                <Text style={{ fontWeight: "bold", marginTop: 20, fontSize: 16, textAlign: "center" }}>
                    {mensagem || "Seu triste IMC aparecerá aqui"}
                </Text>
            </View>
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: "#ffff00",
        justifyContent: "center", padding: 24

    },
    titulo: {
        fontSize: 20,
        textAlign: "center",
        fontWeight: "bold",
    },
    input: {
        height: 48,
        borderRadius: 10,
        borderWidth: 1,
        backgroundColor: "#ffffe6",
        margin: 5
    },
    botao: {
        justifyContent: "center",
        alignItems: "center",
        height: 48,
        borderRadius: 10,
        borderWidth: 1,
        backgroundColor: "#ffffe6",
        margin: 5

    }
});
