import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class ProductHelper {
  static Future<void> criaTabela(sql.Database database) async {
    await database.execute(""" CREATE TABLE tbProdutos(
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
idUsuario INTEGER,
idComunidade INTEGER DEFAULT 1,
imagem TEXT,
descricao TEXT,
status BOOLEAN,
createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
createdIdUser INTEGER NOT NULL,
updatedAt TIMESTAMP,
updatedIdUser INTEGER NOT NULL
); """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'tbProdutos.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await criaTabela(database);
      },
    );
  }

  static Future<int> addProduct(int idUser, int idComunidade, String imagem, String descricao, bool status, DateTime createdAt, int createdIdUser, DateTime updatedAt, int updatedIdUser) async {
    final db = await ProductHelper.db();
    final dados = {'idUsuario': idUser, 'idComunidade': idComunidade, 'imagem': imagem,
      'descricao': descricao, 'status': status ,
      'createdAt': createdAt, 'createdIdUser': createdIdUser,
      'updatedAt': updatedAt, 'updatedIdUser': updatedIdUser
    };
    final id = await db.insert('tbProdutos', dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllProducts() async {
    final db = await ProductHelper.db();
    return db.query('tbProdutos', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getProductById(int id) async {
    final db = await ProductHelper.db();
    return db.query('tbProdutos', where: "id = ?", whereArgs: [id], limit: 1);
  }

}


