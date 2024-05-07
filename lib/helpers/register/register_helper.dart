import 'package:giveandgetapp/pages/authentication/login/login_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class RegisterHelper {
  static recoverBD() async {
    final pathBD = await getDatabasesPath();
    final localBD = join(pathBD, "banco.bd");
    var bd = await openDatabase(
        localBD,
        version: 1,
        onCreate: (db, dbVersaoRecente){
          String sql = "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, cpf VARCHAR, primeiroNome VARCHAR,ultimoNome VARCHAR, email VARCHAR,senha VARCHAR) ";
          db.execute(sql);
        }
    );
    return bd;
    print("BD acessado: " + bd.isOpen.toString());
  }

  static saveDados(String cpf, String primeiroNome,String ultimoNome,String email,String senha) async {
    Database bd = await recoverBD();
    Map<String, dynamic> dadosUser = {
      "cpf" : cpf,
      "primeiroNome" : primeiroNome,
      "ultimoNome": ultimoNome,
      "email": email,
      "senha": senha
    };
    int id = await bd.insert("usuarios", dadosUser);
    print("Usuário Salvo ID: $id " + "Cpf: $cpf");
  }

  _listarUsuarios() async{
    Database bd = await recoverBD();
    String sql = "SELECT * FROM usuarios";
    //String sql = "SELECT * FROM usuarios WHERE idade=58";
    //String sql = "SELECT * FROM usuarios WHERE idade >=30 AND idade <=58";
    //String sql = "SELECT * FROM usuarios WHERE idade BETWEEN 18 AND 58";
    //String sql = "SELECT * FROM usuarios WHERE nome='Maria Silva'";
    List usuarios = await bd.rawQuery(sql); //conseguimos escrever a query que quisermos
    for(var user in usuarios){
      print(" id: "+user['id'].toString() +
          " nome: "+user['nome']+
          " idade: "+user['idade'].toString());
    }
  }

  _listarUmUsuario(int id) async{
    Database bd = await recoverBD();
    List usuarios = await bd.query(
        "usuarios",
        columns: ["id", "nome", "idade"],
        where: "id = ?",
        whereArgs: [id]
    );
    for(var user in usuarios){
      print(" id: "+user['id'].toString() +
          " nome: "+user['nome']+
          " idade: "+user['idade'].toString());
    }
  }

  /*_excluirUsuario(int id) async{
    Database bd = await _recuperarBancoDados();
    int retorno = await bd.delete(
        "usuarios",
        where: "id = ?",  //caracter curinga
        whereArgs: [id]
    );
    print("Itens excluidos: "+retorno.toString());
  }*/

  _excluirUsuario() async{
    Database bd = await recoverBD();
    int retorno = await bd.delete(
        "usuarios",
        where: "nome = ? AND idade = ?",  //caracter curinga
        whereArgs: ["Raquel Ribeiro", 26]
    );
    print("Itens excluidos: "+retorno.toString());
  }

  _atualizarUsuario(int id) async{
    Database bd = await recoverBD();
    Map<String, dynamic> dadosUsuario = {
      "nome" : "Antonio Pedro",
      "idade" : 35,
    };
    int retorno = await bd.update(
        "usuarios", dadosUsuario,
        where: "id = ?",  //caracter curinga
        whereArgs: [id]
    );
    print("Itens atualizados: "+ retorno.toString());
  }
}