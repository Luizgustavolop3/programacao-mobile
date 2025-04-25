//Importa o pacote necessário para interface
import 'package:flutter/material.dart';

//função principal
void main() => runApp(SpotifyPerfil());

//classe principal
class SpotifyPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nebula Band',
      debugShowCheckedModeBanner: false, //removendo a faixa de debug
      theme: ThemeData(
//temas e cores
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF1A1A2E),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF6A1B9A),
          secondary: Color(0xFFFF9800),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: PerfilArtistaPage(),
    );
  }
}

//página do artista
class PerfilArtistaPage extends StatefulWidget {
  @override
  State<PerfilArtistaPage> createState() => _PerfilArtistaPageState();
}

//informações do artista
class _PerfilArtistaPageState extends State<PerfilArtistaPage> {
  final String nome = "Nebula Band";
  final String ouvintes = "1.2M ouvintes mensais";
  final String biografia =
      "A Nebula Band é conhecida por seu som etéreo e letras introspectivas. "
      "Desde seu álbum de estreia, a banda norueguesa conquistou fãs ao redor do mundo.";

  final List<Map<String, String>> albuns = [
    {
      "titulo": "Reflexos Cósmicos",
      "url": "https://cdn-images.dzcdn.net/images/cover/8848c366508735e513fed3e2c6f2a6d1/0x1900-000000-80-0-0.jpg"
    },
    {
      "titulo": "Nebulosa",
      "url": "https://cdn-images.dzcdn.net/images/artist/e18ef0a6c3bc33473cfc6fba9b1e773f/1900x1900-000000-80-0-0.jpg"
    },
    {
      "titulo": "Som das Estrelas",
      "url": "https://upload.wikimedia.org/wikipedia/commons/e/ec/Record-Album-02.jpg"
    },
    {
      "titulo": "Horizonte Vazio",
      "url": "https://cdn-images.dzcdn.net/images/cover/ee2ec330daddb9ef21e0f988c18750b2/0x1900-000000-80-0-0.jpg"
    },
  ];

//controle de botão de seguir e player
  bool seguindo = false;
  bool tocando = false;
  int musicaAtualIndex = 0;

  final List<String> playlist = [
    "Nebula Dreams",
    "Ecos do Vazio",
    "Horizonte Silencioso",
    "Aurora Boreal",
    "Som das Estrelas",
    "Vórtice Sonoro",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( //rolagem da tela
          child: Column(
            children: [
              Stack( //imagem e nome da banda
                children: [
                  Image.network(
                    'https://i0.wp.com/musicalidades.com.br/wp-content/uploads/2018/11/o-que-e-musica-4.jpg?fit=1080%2C512&ssl=1',
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      nome,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10,
                            color: Colors.black87,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding( //bloco com ouvintes, biografia, botões
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ouvintes, style: TextStyle(color: Colors.orangeAccent)),
                    SizedBox(height: 8),
                    Text(
                      biografia,
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Color(0xFF2C2C54),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                              ),
                              builder: (_) {
                                return StatefulBuilder(
                                  builder: (context, setModalState) {
                                    void togglePlay() {
                                      setModalState(() => tocando = !tocando);
                                    }

                                    void proximaMusica() {
                                      setModalState(() {
                                        musicaAtualIndex = (musicaAtualIndex + 1) % playlist.length;
                                        tocando = true;
                                      });
                                    }

                                    void musicaAnterior() {
                                      setModalState(() {
                                        musicaAtualIndex = (musicaAtualIndex - 1 + playlist.length) % playlist.length;
                                        tocando = true;
                                      });
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Tocando agora:',
                                            style: TextStyle(color: Colors.white70, fontSize: 16),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            playlist[musicaAtualIndex],
                                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.skip_previous, color: Colors.orangeAccent, size: 32),
                                                onPressed: musicaAnterior,
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  tocando ? Icons.pause_circle : Icons.play_circle,
                                                  color: Colors.orange,
                                                  size: 48,
                                                ),
                                                onPressed: togglePlay,
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.skip_next, color: Colors.orangeAccent, size: 32),
                                                onPressed: proximaMusica,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.play_arrow),
                          label: Text("Reproduzir"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFF9800),
                            foregroundColor: Colors.black,
                          ),
                        ),
                        SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              seguindo = !seguindo;
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: BorderSide(color: Colors.purple.shade300),
                          ),
                          child: Text(seguindo ? 'Seguindo' : 'Seguir'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Discografia',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              Container( //list horizontal dos álbuns
                height: 180,
                margin: EdgeInsets.only(top: 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: albuns.length,
                  itemBuilder: (context, index) {
                    final album = albuns[index];
                    return GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tocando: ${album["titulo"]}')),
                        );
                      },
                      child: Container(
                        width: 140,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                album["url"]!,
                                height: 120,
                                width: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              album["titulo"]!,
                              style: TextStyle(fontSize: 14, color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Curiosidades',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 10),
                    curiosidadeItem(Icons.star, 'Já abriu shows para Aurora e Sigur Rós.'),
                    curiosidadeItem(Icons.public, 'Tem fãs em mais de 30 países.'),
                    curiosidadeItem(Icons.headphones, 'Teve 50 milhões de streams em 2024.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget curiosidadeItem(IconData icone, String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icone, color: Colors.orangeAccent, size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              texto,
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}



