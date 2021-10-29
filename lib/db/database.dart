import 'dart:async';
import 'dart:io';

import 'package:hulk_store/models/products_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseProvider {

  DataBaseProvider._privateConstructor();
  static final DataBaseProvider instance = DataBaseProvider._privateConstructor();


  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ProductsDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Products ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "description TEXT,"
          "price TEXT,"
          "quantity TEXT,"
          "image TEXT,"
          "idProduct TEXT"
          ")");
    });
  }

  /* Method to create new product */
  newProduct(ProductModel newProduct) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Products");
    int id = 1;
    if(table.first["id"] != null){
      id = table.first["id"] as int;
    }
    var raw = await db.rawInsert(
        "INSERT Into Products (id,name,description,price,quantity,image, idProduct)"
        " VALUES (?,?,?,?,?,?,?)",
        [id, newProduct.name, newProduct.description, newProduct.price, newProduct.quantity ,newProduct.image, newProduct.idProduct]);
    return raw;
  }

  /* Method to update product information */
  updateProduct(ProductModel newProduct) async {
    final db = await database;
    var res = await db.update("Products", newProduct.toMap(),
        where: "idProduct = ?", whereArgs: [newProduct.idProduct]);
    return res;
  }

  /* Method to obtain the information of a product according to its idProduct */
  getProduct(String idProduct) async {
    final db = await database;
    var res = await db.query("Products", where: "idProduct = ?", whereArgs: [idProduct]);
    return res.isNotEmpty ? ProductModel.fromMap(res.first) : null;
  }

  /* Method to obtain all the products */
  Future<List<ProductModel>> getAllProducts() async {
    final db = await database;
    var res = await db.query("Products");
    List<ProductModel> list =
        res.isNotEmpty ? res.map((c) => ProductModel.fromMap(c)).toList() : [];
    return list;
  }

}
