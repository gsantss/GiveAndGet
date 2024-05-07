import 'package:flutter/material.dart';
import 'package:giveandgetapp/helpers/product/product_helper.dart';
import 'package:giveandgetapp/shared/widgets/item_list.dart';
import '../../shared/widgets/float_button.dart';
import '../about/about.dart';
import '../authentication/login/login_page.dart';
import '../product/product_detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> _produtos = [];
  bool _atualizando = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() async {
    final db = await ProductHelper.db();
    final List<Map<String, dynamic>> productsList = await db.query('tbProdutos', orderBy: "id");
    setState(() {
      _produtos = productsList;
      _atualizando = false;
    });
  }

  void _openProductDetail() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => productDetail()),
    );

    // Checa se result é true, o que significa que um produto foi adicionado
    if (result == true) {
      _loadProducts(); // Re-carrega a lista de produtos para refletir a nova adição
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.accessibility_new, color: Colors.white,),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => About())
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            icon: Icon(Icons.person),
            color: Colors.white,
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(25)
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
                  hintStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.normal)),
            ),
          ),
          Expanded(
            child: _atualizando
                ? Center(child: CircularProgressIndicator())
                : ListView.separated(
              itemCount: _produtos.length,
              itemBuilder: (BuildContext context, int index) {
                var produto = _produtos[index];
                return ItemList(
                  title: produto['nome'], // Certifique-se de que este campo corresponde ao banco de dados
                  description: produto['descricao'], // Certifique-se de que este campo corresponde ao banco de dados
                  image: produto['imagem'], // A imagem precisa ser uma URL ou caminho local válido
                  community: produto['comunidade'], // Este campo também precisa ser extraído do banco
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(height: 10);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openProductDetail,
        tooltip: 'Adicionar Produto',
        child: Icon(Icons.add),
      ),
    );
  }
}
