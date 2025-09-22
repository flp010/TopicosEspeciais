import { useState, useEffect } from "react"
import { SafeAreaView, View, Text, FlatList, ActivityIndicator, Image, StyleSheet, Linking, TouchableOpacity, } from "react-native"
import { NavigationContainer } from "@react-navigation/native"
import { createDrawerNavigator } from "@react-navigation/drawer"

function PokemonScreen() {
    const [carregando, setCarregando] = useState(true)
    const [pokemons, setPokemons] = useState([])
    const [pagina, setPagina] = useState(0)

    useEffect(() => {
        const fetchPokemons = async () => {
            setCarregando(true)
            try {
                const res = await fetch(
                    `https://pokeapi.co/api/v2/pokemon?limit=10&offset=${pagina * 10}`
                )
                const json = await res.json()

                const lista = await Promise.all(
                    json.results.map(async (p) => {
                        const detalhe = await fetch(p.url).then((res) => res.json())
                        return {
                            name: p.name,
                            image: detalhe.sprites.front_default,
                            mainType: detalhe.types[0].type.name,
                        }
                    })
                )
                setPokemons(lista)
            } catch (err) {
                console.error("Erro ao buscar pokémons", err)
            } finally {
                setCarregando(false)
            }
        }

        fetchPokemons()
    }, [pagina])


    const renderItem = ({ item }) => (
        <View style={styles.item}>
            <Image source={{ uri: item.image }} style={styles.avatar} />
            <View>
                <Text style={styles.nome}>{item.name}</Text>
                <Text>Tipo: {item.mainType}</Text>
            </View>
        </View>
    )

    return (
        <SafeAreaView style={styles.container}>
            <Text style={styles.titulo}> Lista de Pokémons </Text>
            {carregando ? (
                <ActivityIndicator size="large" color="#2563EB" />
            ) : (
                <>
                    <FlatList
                        data={pokemons}
                        keyExtractor={(item, index) => index.toString()}
                        renderItem={renderItem}
                        ListEmptyComponent={<Text>Nenhum Pokémon encontrado</Text>}
                    />
                    <TouchableOpacity
                        style={styles.botao}
                        onPress={() => setPagina((p) => p + 1)}
                    >
                        <Text style={styles.botaoTexto}>Próximo</Text>
                    </TouchableOpacity>
                </>
            )}
        </SafeAreaView>
    )
}

function UniversityScreen() {
    const [carregando, setCarregando] = useState(true);
    const [universidades, setUniversidades] = useState([]);
    const [pagina, setPagina] = useState(0);

    useEffect(() => {
        const fetchUniversidades = async () => {
            setCarregando(true)
            try {
                const res = await fetch("http://universities.hipolabs.com/search?country=Brazil");
                const json = await res.json()
                const start = pagina * 10;
                setUniversidades(json.slice(start, start + 10))
            } catch (err) {
                console.error("Erro ao buscar universidades", err)
            } finally {
                setCarregando(false)
            }
        }

        fetchUniversidades()
    }, [pagina])


    const renderItem = ({ item }) => (
        <View style={styles.item}>
            <View>
                <Text style={styles.nome}>{item.name}</Text>
                <Text>País: {item.country}</Text>
                {item.web_pages && item.web_pages[0] ? (
                    <TouchableOpacity onPress={() => Linking.openURL(item.web_pages[0])}>
                        <Text style={styles.link}>{item.web_pages[0]}</Text>
                    </TouchableOpacity>
                ) : (
                    <Text>Sem site</Text>
                )}
            </View>
        </View>
    )

    return (
        <SafeAreaView style={styles.container}>
            <Text style={styles.titulo}> Universidades do Brasil </Text>
            {carregando ? (
                <ActivityIndicator size="large" color="#16A34A" />
            ) : (
                <>
                    <FlatList
                        data={universidades}
                        keyExtractor={(item, index) => index.toString()}
                        renderItem={renderItem}
                        ListEmptyComponent={<Text>Nenhuma universidade encontrada</Text>}
                    />
                    <TouchableOpacity
                        style={styles.botao}
                        onPress={() => setPagina((p) => p + 1)}
                    >
                        <Text style={styles.botaoTexto}>Próximo</Text>
                    </TouchableOpacity>
                </>
            )}
        </SafeAreaView>
    )
}

function BooksScreen() {
    const [carregando, setCarregando] = useState(true)
    const [livros, setLivros] = useState([])
    const [pagina, setPagina] = useState(0)

    useEffect(() => {
        const fetchLivros = async () => {
            setCarregando(true)
            try {
                const res = await fetch("https://openlibrary.org/subjects/fantasy.json?limit=50")
                const json = await res.json()
                const lista = json.works || []
                const start = pagina * 10
                const dados = lista
                    .slice(start, start + 10)
                    .map((w) => ({
                        title: w.title,
                        author: w.authors?.[0]?.name ?? "Desconhecido",
                        year: w.first_publish_year ?? "N/D",
                    }))
                setLivros(dados)
            } catch (err) {
                console.error("Erro ao buscar livros", err)
            } finally {
                setCarregando(false)
            }
        }

        fetchLivros()
    }, [pagina])

    const renderItem = ({ item }) => (
        <View style={styles.item}>
            <View>
                <Text style={styles.nome}>{item.title}</Text>
                <Text>Autor: {item.author}</Text>
                <Text>Ano: {item.year}</Text>
            </View>
        </View>
    );

    return (
        <SafeAreaView style={styles.container}>
            <Text style={styles.titulo}> Livros de Fantasia </Text>
            {carregando ? (
                <ActivityIndicator size="large" color="#DC2626" />
            ) : (
                <>
                    <FlatList
                        data={livros}
                        keyExtractor={(item, index) => index.toString()}
                        renderItem={renderItem}
                        ListEmptyComponent={<Text>Nenhum livro encontrado</Text>}
                    />
                    <TouchableOpacity
                        style={styles.botao}
                        onPress={() => setPagina((p) => p + 1)}
                    >
                        <Text style={styles.botaoTexto}>Próximo</Text>
                    </TouchableOpacity>
                </>
            )}
        </SafeAreaView>
    );
}

const Drawer = createDrawerNavigator()

export default function App() {
    return (
        <NavigationContainer>
            <Drawer.Navigator initialRouteName="Pokémons">
                <Drawer.Screen name="Pokémons" component={PokemonScreen} />
                <Drawer.Screen name="Universidades" component={UniversityScreen} />
                <Drawer.Screen name="Livros de Fantasia" component={BooksScreen} />
            </Drawer.Navigator>
        </NavigationContainer>
    )
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        padding: 16,
        backgroundColor: "#F9FAFB",
    },
    titulo: {
        fontSize: 22,
        fontWeight: "bold",
        marginBottom: 12,
        textAlign: "center",
    },
    item: {
        flexDirection: "row",
        alignItems: "center",
        padding: 12,
        marginBottom: 8,
        backgroundColor: "#fff",
        borderRadius: 8,
        shadowColor: "#000",
        shadowOpacity: 0.05,
        shadowRadius: 4,
        elevation: 2,
    },
    avatar: {
        width: 56,
        height: 56,
        borderRadius: 28,
        marginRight: 12,
    },
    nome: {
        fontWeight: "bold",
        fontSize: 16,
        marginBottom: 4,
    },
    link: {
        color: "#2563EB",
        textDecorationLine: "underline",
    },
    botao: {
        marginTop: 10,
        padding: 12,
        backgroundColor: "#2563EB",
        borderRadius: 8,
        alignItems: "center",
    },
    botaoTexto: {
        color: "#fff",
        fontWeight: "bold",
        fontSize: 16,
    },
})