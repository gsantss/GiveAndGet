import 'package:giveandgetapp/pages/authentication/login/login_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart' as sql;

class AuthenticationHelper {
  static Future<void> criaTabela(sql.Database databaseC) async {
    await databaseC.execute(""" CREATE TABLE tbCadastro(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        idTipoCadastro INTEGER NOT NULL,
        nome TEXT NOT NULL,
        cpf TEXT NOT NULL,
        login TEXT NOT NULL,
        senha TEXT NOT NULL
    );""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'tbCadastro.db',
      version: 1,
      onCreate: (sql.Database databaseC, int version) async {
        await criaTabela(databaseC);
      },
    );
  }

  static Future<int> addUser(int idUser,int idTipoCadastro, String nome, String cpf, String login,String senha) async {
    final db = await AuthenticationHelper.db();
    final dados = {'id': idUser,'idTipoCadastro':idTipoCadastro, 'nome': nome,
      'cpf': cpf, 'login': login ,
      'senha': senha,
    };
    final id = await db.insert('tbCadastro', dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

}