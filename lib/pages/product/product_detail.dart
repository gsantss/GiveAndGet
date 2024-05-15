//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:giveandgetapp/helpers/product/product_helper.dart';
import 'package:giveandgetapp/pages/home/home_page.dart';

class ComunityList {
  String label = '';
  int value = 0;

  ComunityList(this.label, this.value);
}



class productDetail extends StatefulWidget {
  @override
  _productDetailScreenState createState() => _productDetailScreenState();
}



class _productDetailScreenState extends State<productDetail> {

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final int _idUsuario = 0;
  String nome = '';
  String descricao = '';
  int comunidadeSelecionada = 0;
  final bool _status = true;

  final List<ComunityList> comunidades = [
    ComunityList('Comunidades', 0),
    ComunityList('PUC-MG', 2),
    ComunityList('PUC-RJ', 3),
    ComunityList('UFMG', 4),
    ComunityList('USP', 5),
    ComunityList('UFOP', 6),
    ComunityList('Outros', 1)
  ];

  void _addProduct() async {
    if (nome.isNotEmpty && descricao.isNotEmpty && comunidadeSelecionada != 0) {

      int productId = await ProductHelper.addProduct(
          _idUsuario,
          comunidadeSelecionada,
          "assets/Imagens.png",
          nome,
          _status
      );

      if (productId != 0) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Produto adicionado com sucesso!"))
        );
        Navigator.pop(context, true); // Retorna true se um produto foi adicionado
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Falha ao adicionar produto."))
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Nome, descrição e comunidade são obrigatórios."))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey, // Adicione isso
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
                    Navigator.pop(context,
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
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: AspectRatio(
                    aspectRatio: 5 / 5,
                    child: Image.asset("lib/assets/images/hands.png", fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 50),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome do Item'),
                  onChanged: (value) {
                    setState(() { nome = value; });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Descrição'),
                  maxLines: null,
                  onChanged: (value) {
                    setState(() { descricao = value; });
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  value: comunidadeSelecionada,
                  hint: Text('Selecione uma comunidade'),
                  items: comunidades.map((comunidade) {
                    return DropdownMenuItem(
                      value: comunidade.value,
                      child: Text(comunidade.label),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() { comunidadeSelecionada = value!; });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: _addProduct,
                  child: Text(
                    'Adicionar',
                    style: TextStyle(color: Colors.white),
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