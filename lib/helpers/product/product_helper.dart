import 'package:sqflite/sqflite.dart' as sql;

class ProductHelper {
  static Future<void> criaTabela(sql.Database database) async {
    await database.execute("""
  CREATE TABLE tbProdutos(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    idUsuario INTEGER,
    idComunidade INTEGER DEFAULT 1,
    imagem TEXT,
    nome TEXT,
    descricao TEXT,
    status BOOLEAN
  );
  """);
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

  static Future<int> addProduct(int idUser, int idComunidade, String imagem, String descricao, bool status) async {
    final db = await ProductHelper.db();
    final dados = {
      'idUsuario': idUser,
      'idComunidade': idComunidade,
      'imagem': imagem,
      'descricao': descricao,
      'status': status
    };
    final id = await db.insert('tbProdutos', dados, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllProducts() async {
    final db = await ProductHelper.db();
    return db.query('tbProdutos', orderBy: "id");
  }

  static Future<int> updateProduct(int? id, int idUser, int idComunidade, String imagem, String descricao, bool status) async {
    final db = await ProductHelper.db();
    final dados = {
      'idUsuario': idUser,
      'idComunidade': idComunidade,
      'imagem': imagem,
      'descricao': descricao,
      'status': status
    };
    return await db.update('tbProdutos', dados, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteProduct(int id) async {
    final db = await ProductHelper.db();
    return await db.delete('tbProdutos', where: 'id = ?', whereArgs: [id]);
  }
}
