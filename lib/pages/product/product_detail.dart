import 'package:flutter/material.dart';
import 'package:giveandgetapp/helpers/product/product_helper.dart';

class ComunityList {
  String label = '';
  int value = 0;

  ComunityList(this.label, this.value);
}

class ProductDetail extends StatefulWidget {
  final Map<String, dynamic>? product;

  const ProductDetail({Key? key, this.product}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetail> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  int _idUsuario = 0;
  String nome = '';
  String descricao = '';
  int comunidadeSelecionada = 0;
  bool _status = true;
  String imagem = '';

  final List<ComunityList> comunidades = [
    ComunityList('Comunidades', 0),
    ComunityList('PUC-MG', 2),
    ComunityList('PUC-RJ', 3),
    ComunityList('UFMG', 4),
    ComunityList('USP', 5),
    ComunityList('UFOP', 6),
    ComunityList('Outros', 1)
  ];

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      nome = widget.product!['nome'] ?? '';
      descricao = widget.product!['descricao'] ?? '';
      comunidadeSelecionada = widget.product!['idComunidade'] is int
          ? widget.product!['idComunidade']
          : int.tryParse(widget.product!['idComunidade'].toString()) ?? 0;
      imagem = widget.product!['imagem'] ?? '';
    }
  }

  void _addOrUpdateProduct() async {
    if (nome.isNotEmpty && descricao.isNotEmpty && comunidadeSelecionada != 0) {
      if (widget.product == null) {
        // Adicionar produto
        int productId = await ProductHelper.addProduct(
          _idUsuario,
          comunidadeSelecionada,
          imagem,
          descricao,
          _status,
        );

        if (productId != 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Produto adicionado com sucesso!")),
          );
          Navigator.pop(context, true); // Retorna true se um produto foi adicionado
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Falha ao adicionar produto.")),
          );
        }
      } else {
        // Atualizar produto
        int result = await ProductHelper.updateProduct(
          widget.product!['id'],
          _idUsuario,
          comunidadeSelecionada,
          imagem,
          descricao,
          _status,
        );

        if (result != 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Produto atualizado com sucesso!")),
          );
          Navigator.pop(context, true); // Retorna true se um produto foi atualizado
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Falha ao atualizar produto.")),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Nome, descrição e comunidade são obrigatórios.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 40),
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
                  child: Image.asset(imagem, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 50),
              TextFormField(
                initialValue: nome,
                decoration: InputDecoration(labelText: 'Nome do Item'),
                onChanged: (value) {
                  setState(() { nome = value; });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: descricao,
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
                onPressed: _addOrUpdateProduct,
                child: Text(
                  widget.product == null ? 'Adicionar' : 'Atualizar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
