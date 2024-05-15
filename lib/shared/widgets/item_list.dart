import 'package:flutter/material.dart';
import 'package:giveandgetapp/helpers/product/product_helper.dart';

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

  void getProductById(int idProd) async {
    int productId = idProd; // ID do produto que você deseja buscar
    var product = await ProductHelper.getProductById(productId);
    print("Produto obtido: $product");
  }

  void deleteProductById(int idProd) async {
    int productId = idProd; // ID do produto que você deseja buscar
    await ProductHelper.deleteProduct(productId);
  }
  
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        deleteProductById(id!);
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
                  "lib/assets/images/hands.png",
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
                    Text("${community}", style: TextStyle(color: Colors.blue)),
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
