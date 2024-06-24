import 'package:flutter/material.dart';
import 'package:giveandgetapp/helpers/product/product_helper.dart';
import 'package:giveandgetapp/pages/about/about.dart';
import 'package:giveandgetapp/pages/authentication/login/login_page.dart';
import 'package:giveandgetapp/pages/product/product_detail.dart';
import 'package:giveandgetapp/shared/widgets/item_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> _produtos = [];
  bool _atualizando = true;

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
    _loadProducts();
  }

  void _loadProducts() async {
    final db = await ProductHelper.db();
    final List<Map<String, dynamic>> productsList = await db.query('tbProdutos', orderBy: 'id');
    setState(() {
      _produtos = productsList;
      _atualizando = false;
    });
  }

  void _showProductDetails(BuildContext context, Map<String, dynamic> produto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(produto['descricao']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(produto['imagem']),
              SizedBox(height: 10),
              Text("Descrição: ${produto['descricao']}"),
              SizedBox(height: 10),
              Text("Comunidade: ${produto['idComunidade']}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetail(product: produto),
                  ),
                ).then((value) {
                  if (value == true) {
                    _loadProducts(); // Recarrega a lista de produtos após a atualização
                  }
                });
              },
              child: Text("Atualizar"),
            ),
            TextButton(
              onPressed: () async {
                await ProductHelper.deleteProduct(produto['id']);
                Navigator.of(context).pop();
                _loadProducts(); // Recarrega a lista de produtos após a exclusão
              },
              child: Text("Excluir"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.accessibility_new, color: Colors.white),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => About()));
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            },
            icon: Icon(Icons.person),
            color: Colors.white,
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextFormField(
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 10, top: 10),
                border: InputBorder.none,
                hintText: "Pesquisar",
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
                hintStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Expanded(
            child: _atualizando
                ? Center(child: CircularProgressIndicator())
                : ListView.separated(
              itemCount: _produtos.length,
              itemBuilder: (BuildContext context, int index) {
                var produto = _produtos[index];
                var comunidade = comunidades.firstWhere((element) => element.value == produto['idComunidade'], orElse: () => ComunityList('Outros', 1)).label;

                return GestureDetector(
                  onTap: () {
                    _showProductDetails(context, produto);
                  },
                  child: ItemList(
                    id: produto['id'],
                    title: produto['descricao'] ?? 'Sem Nome',
                    description: produto['descricao'] ?? 'Sem Descrição',
                    image: produto['imagem'] ?? 'assets/default.png',
                    community: comunidade,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Container(height: 10),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail())).then((value) {
            if (value == true) {
              _loadProducts(); // Recarrega a lista de produtos após adicionar um novo produto
            }
          });
        },
        tooltip: 'Adicionar Produto',
        child: Icon(Icons.add),
      ),
    );
  }
}
