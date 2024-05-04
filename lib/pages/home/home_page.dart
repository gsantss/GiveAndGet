import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:giveandgetapp/pages/about/about.dart';
import 'package:giveandgetapp/shared/widgets/item_list.dart';
import '../../shared/widgets/float_button.dart';
import '../authentication/login/login_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> _produtos = [];
  bool _atualizando = true;

  final int _idUsuario = 0;
  final TextEditingController _imagem = TextEditingController();
  final TextEditingController _descricao = TextEditingController();
  final bool _status = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.accessibility_new, color: Colors.white,),
          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=>About())
            );
        },),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            icon: Icon(Icons.person),
            color: Colors.white,
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body:  Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Container(
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
            ),
          ),
          Expanded(

            child: ListView.separated(
                itemCount: 30,
                itemBuilder: (BuildContext context, int index){
              return ItemList();
            }, separatorBuilder: (BuildContext context, int index) {
                  return Container(height: 7,);
            },),
          ),

        ],
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatButton(),
    );
  }
}
