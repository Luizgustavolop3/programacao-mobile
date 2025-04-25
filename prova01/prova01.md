
**EQUIPE**
- AUGUSTO CESAR BONTORIN
- LUCAS EUGÊNIO FLORIANO DE MORAES
- LUIZ GUSTAVO LOPES

________________________________________
 **PROTÓTIPO 1 - Catálogo de Viagens** 
________________________________________
**1. MaterialApp**

**Descrição**: Widget raiz que define tema, título e tela inicial.

**Aplicações**: Define o tema do app e o ponto de entrada com CatalogoPage.

**Como usar**:

    return MaterialApp(
      title: 'Catálogo de Viagens',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: CatalogoPage(),
    );
________________________________________
**2. Scaffold**

**Descrição**: Estrutura básica de layout com AppBar, body e outros.

**Aplicações**: Envolve a tela principal do aplicativo e tela de detalhes.

**Como usar**:

    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Viagens'),
      ),
      body: Column(
        children: <Widget>[ (...)

________________________________________
**3. Column**

**Descrição**: Organiza widgets verticalmente.

**Aplicações**: Utilizado para organizar cards de destino e botões.

**Como usar**:

      body: Column(
        children: <Widget>[
          (...)
                  Image.network(
                    (...)          
                    child: Text(
                      (...)
                  Row(
                    (...)

________________________________________
**4. Row**

**Descrição**: Organiza widgets horizontalmente.

**Aplicações**: Alinha os botões de "Ver Detalhes" e "Reservar" lado a lado.

**Como usar**:

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(

________________________________________
**5. ListView.builder**

**Descrição**: Lista de rolagem com renderização sob demanda.

**Aplicações**: Exibe todos os destinos disponíveis em cards.

**Como usar**:

          Expanded(
            child: ListView.builder(
              itemCount: destinos.length,
              itemBuilder: (context, index) {

________________________________________
**6. Navigator.push**

**Descrição**: Navega para outra tela empilhando no histórico.

**Aplicações**: Abre a página de detalhes do destino selecionado.

**Como usar**:


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalhesPage(

________________________________________
**7. showDialog**

**Descrição**: Mostra uma caixa de diálogo modal.

**Aplicações**: Usado para reservar destinos e confirmar reservas.

**Como usar**:

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(

________________________________________
**8. StatefulBuilder**

**Descrição**: Permite reconstruir parte da UI dentro do showDialog.

**Aplicações**: Atualiza as datas selecionadas dinamicamente dentro do modal.

**Como usar**:

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Center(child: Text('Reserva')),
              content: Column(

________________________________________
**9. showDatePicker**

**Descrição**: Exibe o seletor de datas do Material Design.

**Aplicações**: Seleciona datas de ida e volta na reserva.

**Como usar**:

                        final dataSelecionada = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );

________________________________________
**10. SnackBar**

**Descrição**: Mensagem temporária para feedback.

**Aplicações**: Notifica o usuário quando há erro na seleção de datas.

**Como usar**:

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selecione as datas de ida e volta.'),
                        ),

________________________________________
 **PROTÓTIPO 2 - Calculadora de IMC** 
________________________________________

**1. Container**

**Descrição**: Componente de layout que permite agrupar e estilizar elementos, como campos de entrada ou resultados.

**Aplicações**: Usado para separar visualmente o formulário de entrada e o box de resultado do IMC.

**Como usar**:

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const
        
________________________________________

**2. Column**

**Descrição**: Empilha widgets verticalmente.

**Aplicações**: Usado para organizar os elementos do formulário, os botões e os resultados.

**Como usar**:

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField

________________________________________

**3. Row**

**Descrição**: Empilha widgets horizontalmente.

**Aplicações**: Alinha os botões "Calcular IMC" e "Limpar Tudo" lado a lado.

**Como usar**:

Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton
                
________________________________________

**4. TextField**

**Descrição**: Campo de entrada de texto.

**Aplicações**: Receber altura e peso do usuário.

**Como usar**:

          TextField(
            controller: alturaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Altura (cm)',
              border: OutlineInputBorder(),
            ),

________________________________________

**5. SizedBox**

**Descrição**: Gera espaços entre os widgets. 
**Aplicações**: Criar espaçamento visual entre elementos da tela. 
**Como usar**:

          const SizedBox(height: 10)

________________________________________

**6. ElevatedButton**

**Descrição**: Botão elevado para interações principais.

**Aplicações**: Botões para calcular o IMC e limpar os campos. 

**Como usar**:

                child: ElevatedButton(
                  onPressed: calcularIMC,
                  child: const Text('Calcular IMC'),

________________________________________

**7. ToggleButtons**

**Descrição**: Conjunto de botões que permite selecionar uma ou mais opções.

**Aplicações**: Seleção de sexo (masculino ou feminino).

**Como usar**:

          ToggleButtons(
            isSelected: isSexoSelecionado,
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < isSexoSelecionado.length; i++) {
                  isSexoSelecionado[i] = i == index;
                }
                (...)
                child: Text('Masculino'),
                 child: Text('Feminino'),

________________________________________

**8. DropdownButton**

**Descrição**: Botão suspenso para selecionar um item de uma lista.

**Aplicações**: Permite que o usuário selecione sua idade. 

**Como usar**:

              return DropdownMenuItem<int>(
                value: idade,
                child: Text('$idade anos'),
              );
            }).toList(),
            onChanged: (int? newValue) 
            
________________________________________

**9. Text**

**Descrição**: Exibe texto na interface.

**Aplicações**: Mostrar mensagens de erro, resultados do IMC, idade e sexo.

**Como usar**:

        children: [
          Text(
            'Seu IMC é: ${imc!.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),

________________________________________

**10. BoxDecoration**

**Descrição**: Permite estilizar containers com cor, borda, sombra e bordas arredondadas. 

**Aplicações**: Usado para dar estilo ao formulário e resultado. 

**Como usar**:

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2)),
        ],


________________________________________
 **PROTÓTIPO 3 - Perfil de Artista Musical** 
________________________________________

**1. MaterialApp**

**Descrição**: Widget raiz da aplicação que configura o tema e a navegação.

**Aplicações**: Define o título, tema escuro com paleta personalizada e tela inicial.

**Como usar**:

    return MaterialApp(
      title: 'Nebula Band',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        (...)
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
        (...)
      home: PerfilArtistaPage(),

________________________________________

**2. Scaffold**

**Descrição**: Estrutura básica de tela com suporte a AppBar, Body, FloatingActionButton etc.

**Aplicações**: Define a tela principal com body e SafeArea.

**Como usar**:

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column

________________________________________

**3. Stack + Positioned**

**Descrição**: Sobrepõe widgets uns sobre os outros.

**Aplicações**: Coloca o nome da banda sobre a imagem de fundo da capa.
**Como usar**:

              Stack( 
                children: [
                  Image.network(
                    'https://',
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 16,

________________________________________

**4. Column**

**Descrição**: Empilha widgets verticalmente.

**Aplicações**: Organiza elementos como biografia, botões e seções.

**Como usar**:

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:

________________________________________

**5. Row**

**Descrição**: Organiza widgets horizontalmente.

**Aplicações**: Agrupa os botões “Reproduzir” e “Seguir”.

**Como usar**:

                    Row(
                      children: [
                        ElevatedButton.icon(
                        (...)
                        OutlinedButton(
                         (...)

________________________________________

**6. ElevatedButton & OutlinedButton**

**Descrição**: Botões de ação com ou sem preenchimento.

**Aplicações**: Um para iniciar a reprodução (e abrir modal), outro para seguir/desseguir o artista.
**Como usar**:

                        ElevatedButton.icon(
                          onPressed: () {
                          (...)
                          label: Text("Reproduzir"),

                        OutlinedButton(
                          onPressed: () {
                          (...)
                          child: Text(seguindo ? 'Seguindo' : 'Seguir')                      

________________________________________

**7. showModalBottomSheet**

**Descrição**: Exibe uma aba deslizante na parte inferior da tela.

**Aplicações**: Mostra a playlist com controles de música.

**Como usar**:

                            showModalBottomSheet(
                              context: context,
                              (...)
                              builder: (_) {
                                return StatefulBuilder(
                                  builder: (context, setModalState) {
                                    void togglePlay() {
                                      setModalState(() => tocando = !tocando);
                                    }


________________________________________

**8. ListView.builder**

**Descrição**: Lista de rolagem dinâmica baseada em dados.

**Aplicações**: Exibe os álbuns da banda na seção “Discografia”.

**Como usar**:

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: albuns.length,
                  itemBuilder: (context, index) 
                  
________________________________________

**9. SnackBar**

**Descrição**: Componente temporário para feedback ao usuário.

**Aplicações**: Exibe a música que está tocando ou foi pausada.

**Como usar**:

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tocando: ${album["titulo"]}')),

________________________________________

**10. StatefulBuilder**

**Descrição**: Permite reatividade dentro de um modal (como uma mini State class).

**Aplicações**: Atualiza o estado dentro do showModalBottomSheet para controle do player.

**Como usar**:

                                return StatefulBuilder(
                                  builder: (context, setModalState) 
