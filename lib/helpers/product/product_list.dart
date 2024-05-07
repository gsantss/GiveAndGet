import 'package:flutter/material.dart';
import 'package:giveandgetapp/helpers/product/product_helper.dart';  // Certifique-se de importar corretamente
import 'package:giveandgetapp/shared/widgets/item_list.dart';  // Certifique-se de que o caminho está correto

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Future<List<Map<String, dynamic>>>? _products;

  @override
  void initState() {
    super.initState();
    _products = ProductHelper.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar produtos"));
          } else if (snapshot.hasData) {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];
                return ItemList(
                    title: product['descricao'],
                    description: "Data de criação: ${product['createdAt']}",
                    image: product['imagem'], community: product['comunidade'] ,
                );
              },
            );
          } else {
            return Center(child: Text("Nenhum produto disponível"));
          }
        },
      ),
    );
  }
}
