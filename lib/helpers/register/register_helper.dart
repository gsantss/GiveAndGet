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


}