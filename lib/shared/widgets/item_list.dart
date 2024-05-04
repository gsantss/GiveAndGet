import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        print("Teste");
      },
      child: Container(

        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(25)
        ),
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Image.network(
              "https://s2-g1.glbimg.com/NrMU35-3lxQbfTs0zmA9sLxOBjM=/0x0:571x561/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2019/B/8/HpPF3PRmC8r1MlL9wN1g/manoelgomes.jpg",
              width: 130,
              height: 150,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Manoel Gomes, de graça!", softWrap: true, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, ), textAlign: TextAlign.left,),
                    Text("Cupido do Amor, 23/04/2024", maxLines: 1, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
