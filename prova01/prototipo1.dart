//importa o pacote principal
import 'package:flutter/material.dart';

//função principal
void main() => runApp(ViagensApp());

//classe principal do app, define o tema a tela inicial
class ViagensApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Viagens',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo, //cor do tema
        scaffoldBackgroundColor: Colors.grey[200], //cor de fundo
      ),
      home: CatalogoPage(), //tela inicial sendo catalogo
    );
  }
}

//widget para gerenciar alterações na tela
class CatalogoPage extends StatefulWidget {
  @override
  _CatalogoPageState createState() => _CatalogoPageState();
}

//destinos, destinos principais com estrela
class _CatalogoPageState extends State<CatalogoPage> {
  final List<Map<String, dynamic>> destinos = [
    {
      'nome': 'Paris - França',
      'imagem': 'https://media.gettyimages.com/id/1443023434/pt/foto/paris-skyline-with-eiffel-tower-at-sunset-aerial-view-france.jpg?s=612x612&w=gi&k=20&c=TkE8PtioPptA_3qxQC48D_xrPJkYX51EafJgDDTHkwI=',
      'destaque': true,
    },
    {
      'nome': 'Rio de Janeiro - Brasil',
      'imagem': 'https://images.unsplash.com/photo-1483729558449-99ef09a8c325?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmlvJTIwZGUlMjBqYW5laXJvJTJDJTIwYnJhemlsfGVufDB8fDB8fHww',
      'destaque': false,
    },
    {
      'nome': 'Tóquio - Japão',
      'imagem': 'https://imgmd.net/images/v1/guia/1684253/tokyo-japao-199-c.jpg',
      'destaque': true,
    },
    {
      'nome': 'Sydney - Austrália',
      'imagem': 'https://australiabrasil.com.br/wp-content/uploads/sites/2/2021/06/sydney-1-2.jpg',
      'destaque': false,
    },
    {
      'nome': 'Cidade do Cabo - África do Sul',
      'imagem': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Aerial_View_of_Sea_Point%2C_Cape_Town_South_Africa.jpg/1200px-Aerial_View_of_Sea_Point%2C_Cape_Town_South_Africa.jpg',
      'destaque': false,
    },
  ];

  Map<String, dynamic> destinoPrincipal;

  _CatalogoPageState()
      : destinoPrincipal = {
          'nome': 'Paris - França',
          'imagem': 'https://media.gettyimages.com/id/1443023434/pt/foto/paris-skyline-with-eiffel-tower-at-sunset-aerial-view-france.jpg?s=612x612&w=gi&k=20&c=TkE8PtioPptA_3qxQC48D_xrPJkYX51EafJgDDTHkwI=',
        };


//atualiza o destino e foto para qual foi selecionado
  void _atualizarDestino(Map<String, dynamic> novoDestino) {
    setState(() {
      destinoPrincipal = novoDestino;
    });
  }

//navega para a tela de detalhes
  void _verDetalhes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalhesPage(
          destino: destinoPrincipal,
          onReservar: _reservar,
        ),
      ),
    );
  }

//função que abre diálogo de data e reserva
  void _reservar() async {
    DateTime? dataIda;
    DateTime? dataVolta;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Center(child: Text('Reserva')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Destino: ${destinoPrincipal['nome']}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                      ),
                      onPressed: () async {
                        final dataSelecionada = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                        if (dataSelecionada != null) {
                          setState(() => dataIda = dataSelecionada);
                        }
                      },
                      child: Text(dataIda == null
                          ? 'Selecionar Data de Ida'
                          : 'Ida: ${dataIda!.day}/${dataIda!.month}/${dataIda!.year}',
                          style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),),
                    ),
                  ),
                  SizedBox(height: 10),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                      ),
                      onPressed: () async {
                        final dataSelecionada = await showDatePicker(
                          context: context,
                          initialDate: dataIda ?? DateTime.now().add(Duration(days: 1)),
                          firstDate: dataIda ?? DateTime.now().add(Duration(days: 1)),
                          lastDate: DateTime.now().add(Duration(days: 730)),
                        );
                        if (dataSelecionada != null) {
                          setState(() => dataVolta = dataSelecionada);
                        }
                      },
                      child: Text(dataVolta == null
                          ? 'Selecionar Data de Volta'
                          : 'Volta: ${dataVolta!.day}/${dataVolta!.month}/${dataVolta!.year}',
                        style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () async {
                    if (dataIda != null && dataVolta != null) {
                      Navigator.of(context).pop();
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Reserva Confirmada'),
                            content: Text(
                              'Reserva confirmada para ${destinoPrincipal['nome']}\n'
                              'Ida: ${dataIda!.day}/${dataIda!.month}/${dataIda!.year} - Volta: ${dataVolta!.day}/${dataVolta!.month}/${dataVolta!.year}',
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selecione as datas de ida e volta.'),
                        ),
                      );
                    }
                  },
                  child: Text('Confirmar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

//constrói a interface principal da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Viagens'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Column(
                children: [
                  Image.network(
                    destinoPrincipal['imagem'],
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      destinoPrincipal['nome'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          elevation: 5,
                          shadowColor: Colors.black,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          textStyle: TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _verDetalhes,
                        child: Text('Ver Detalhes'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          foregroundColor: Theme.of(context).colorScheme.onSecondary,
                          elevation: 5,
                          shadowColor: Colors.black,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          textStyle: TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _reservar,
                        child: Text('Reservar'),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: destinos.length,
              itemBuilder: (context, index) {
                final destino = destinos[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 2,
                  child: ListTile(
                    leading: Image.network(
                      destino['imagem'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(destino['nome']),
                    trailing: destino['destaque'] ? Icon(Icons.star, color: Colors.amber) : null,
                    onTap: () => _atualizarDestino(destino),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//mostra os detalhes de um destino
class DetalhesPage extends StatelessWidget {
  final Map<String, dynamic> destino;
  final VoidCallback onReservar;

  DetalhesPage({required this.destino, required this.onReservar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes de ${destino['nome']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              destino['imagem'],
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              destino['nome'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Mais informações sobre ${destino['nome']} estarão aqui em breve.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                elevation: 5,
                shadowColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onReservar,
              child: Text('Reservar'),
            ),
          ],
        ),
      ),
    );
  }
}





