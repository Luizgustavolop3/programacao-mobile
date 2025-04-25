
// importa o pacote base
import 'package:flutter/material.dart';

//função principaç
void main() => runApp(IMCCalculatorApp());

// widget principal – define tema e tela inicial
class IMCCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[300],
      ),
      home: IMCCalculatorPage(),
    );
  }
}

// tela com estado onde ocorre o cálculo do IMC
class IMCCalculatorPage extends StatefulWidget {
  @override
  _IMCCalculatorPageState createState() => _IMCCalculatorPageState();
}

// controladores de texto (altura e peso)
class _IMCCalculatorPageState extends State<IMCCalculatorPage> {
  final alturaController = TextEditingController();
  final pesoController = TextEditingController();
  double? imc;
  String classificacao = "";
  String? erro;

//seleciona idade e sexo
  List<bool> isSexoSelecionado = [true, false]; // [Masculino, Feminino]
  int? idadeSelecionada;

//função calcular imc
  void calcularIMC() {
    final alturaCm = double.tryParse(alturaController.text);
    final peso = double.tryParse(pesoController.text);

//verifica se os campos foram preenchidos
    if (alturaCm == null || peso == null || alturaCm <= 0 || peso <= 0 || idadeSelecionada == null) {
      setState(() {
        imc = null;
        classificacao = "";
        erro = "Por favor, preencha todos os campos corretamente.";
      });
      return;
    }

    final altura = alturaCm / 100;
    final resultado = peso / (altura * altura);

    setState(() {
      imc = resultado;
      classificacao = _classificarIMC(resultado);
      erro = null;
    });
  }

//função limpar campos
  void limparCampos() {
    setState(() {
      alturaController.clear();
      pesoController.clear();
      imc = null;
      classificacao = "";
      idadeSelecionada = null;
      erro = null;
      isSexoSelecionado = [true, false];
    });
  }

//retorna a classificação com base no valor do IMC
  String _classificarIMC(double imc) {
    if (imc < 18.5) return "Abaixo do peso";
    if (imc < 24.9) return "Peso normal";
    if (imc < 29.9) return "Sobrepeso";
    if (imc < 34.9) return "Obesidade Grau I";
    if (imc < 39.9) return "Obesidade Grau II";
    return "Obesidade Grau III";
  }

//constrói a interface principal
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Calculadora de IMC'))),
      body: SingleChildScrollView(//reolagem da tela
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInputBox(),
            const SizedBox(height: 20),
            if (erro != null)
              Text(
                erro!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            if (imc != null) _buildResultadoBox(),
          ],
        ),
      ),
    );
  }

// caixa com os campos de entrada (input)
  Widget _buildInputBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: alturaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Altura (cm)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: pesoController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Peso (kg)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Sexo', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          ToggleButtons(
            isSelected: isSexoSelecionado,
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < isSexoSelecionado.length; i++) {
                  isSexoSelecionado[i] = i == index;
                }
              });
            },
            borderRadius: BorderRadius.circular(8),
            selectedColor: Colors.white,
            fillColor: Colors.teal,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Masculino'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Feminino'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Idade', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          DropdownButton<int>(
            value: idadeSelecionada,
            hint: const Text('Selecione sua idade'),
            isExpanded: true,
            items: List.generate(100, (index) => index + 1).map((int idade) {
              return DropdownMenuItem<int>(
                value: idade,
                child: Text('$idade anos'),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                idadeSelecionada = newValue;
              });
            },
          ),
          const SizedBox(height: 20),
         
// botões de calcular e limpar
 Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: calcularIMC,
                  child: const Text('Calcular IMC'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: limparCampos,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Limpar Tudo'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//caixa com os resultados do cálculo
  Widget _buildResultadoBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Seu IMC é: ${imc!.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Classificação: $classificacao',
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          if (idadeSelecionada != null)
            Text(
              'Idade: $idadeSelecionada anos',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 10),
          Text(
            'Sexo: ${isSexoSelecionado[0] ? "Masculino" : "Feminino"}',
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
