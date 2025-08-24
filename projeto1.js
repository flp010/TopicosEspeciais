import {SafeAreaView, Text, View, Button, StyleSheet } from 'react-native'
import {useState} from 'react'

export default function app(){
    const [clicou, setClicou] = useState(false)
    const alternamensagem = () => setClicou ( (prev) => !prev )   
    return(
        <SafeAreaView style={styles.container}>
            <Text style = {styles.titulo}> 
                Ola, React Native 
            </Text>
            <Text style = {styles.msg}> 
                {clicou ? "você clicou no botão" : "Toque no Botão"} 
            </Text>
            <View style = {styles.area}>  
                <Button  title={clicou ? "Resetar" : "Clique Aqui"}
                onPress={alternamensagem}/>
            </View>
        </SafeAreaView>
    )
}

const styles = StyleSheet.create({
    container:{
        flex: 1,
        padding: 24,
        justifyContent: "center",
        alignItems: "center",
        backgroundcolor: "#f5f7cb",
    },
    titulo:{
        fontsize: 24,
        fontWeight: "bold",
        marginBottom: 12,
    },
    msg:{
        fontsize: 18,
        marginBottom: 20,
        textAlign: "center",
    },
    area:{
        width: 200,
    }
})