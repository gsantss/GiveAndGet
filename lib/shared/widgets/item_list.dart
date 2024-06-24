import 'package:flutter/material.dart';
import 'package:giveandgetapp/helpers/product/product_helper.dart';
import 'package:giveandgetapp/pages/product/product_detail.dart';

class ItemList extends StatelessWidget {
  final int? id;
  final String title;
  final String description;
  final String image;
  final String community;

  const ItemList({
    Key? key,
    this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.community,
  }) : super(key: key);

  void _showProductDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),  // Exibindo o nome do produto
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(image),
              SizedBox(height: 10),
              Text("Descrição: $description"),  // Exibindo a descrição do produto
              SizedBox(height: 10),
              Text("Comunidade: $community"),  // Exibindo a comunidade do produto
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Fechar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetail(product: {
                      'id': id,
                      'nome': title,
                      'descricao': description,
                      'idComunidade': community,
                      'imagem': image
                    }),
                  ),
                ).then((value) {
                  if (value == true) {
                    // Se precisar atualizar a lista de produtos após a atualização
                  }
                });
              },
              child: Text("Atualizar"),
            ),
            TextButton(
              onPressed: () async {
                await ProductHelper.deleteProduct(id!);
                Navigator.of(context).pop();
                // Se precisar atualizar a lista de produtos após a exclusão
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
    return GestureDetector(
      onTap: () {
        _showProductDetails(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              child: Expanded(
                child: Image.asset(
                  image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(description),
                    Text("$community", style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
