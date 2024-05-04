import 'package:flutter/material.dart';
import 'package:giveandgetapp/pages/home/home_page.dart';

class productDetail extends StatefulWidget {
  @override
  _productDetailScreenState createState() => _productDetailScreenState();
}

class _productDetailScreenState extends State<productDetail> {
  String nome = '';
  String descricao = '';
  String comunidadeSelecionada = 'Comunidades';

  final List<String> comunidades = [
    'Comunidades',
    'PUC-MG',
    'PUC-RJ',
    'UFMG',
    'USP',
    'UFOP',
    'Outros',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 9, 12, 14), 
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(

        appBar: AppBar(

          backgroundColor: Colors.blue,
          title: Row(
            children: [
              GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>Home())
                    );
                  },
                  child: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 40,)
              ),
              Text(
                'Detalhes',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                20.0, 20.0, 20.0, 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                  },
                  child: AspectRatio(
                    aspectRatio:
                    5 / 5,
                    child: Image.asset(
                      "assets/Imagens.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome do Item'),
                  onChanged: (value) {
                    setState(() {
                      nome = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Descrição'),
                  maxLines: null,
                  onChanged: (value) {
                    setState(() {
                      descricao = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  value: comunidadeSelecionada,
                  hint: Text(
                      'Selecione uma comunidade'), // Adiciona uma dica ao campo
                  items: comunidades.map((comunidade) {
                    return DropdownMenuItem(
                      value: comunidade,
                      child: Text(comunidade),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      comunidadeSelecionada = value.toString();
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    // Lógica para productDetail o item
                    print('Nome: $nome');
                    print('Descrição: $descricao');
                    print('Comunidade: $comunidadeSelecionada');
                  },
                  child: Text(
                    'Adicionar',
                    style: TextStyle(color: Colors.white), // Cor do texto do botão
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
