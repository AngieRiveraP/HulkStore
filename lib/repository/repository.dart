import 'dart:async';
import 'dart:io';

import 'package:hulk_store/db/database.dart';
import 'package:hulk_store/models/products_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Repository {

  /*Method to obtain all the products saved in the database*/
  Future<List<ProductModel>> getProducts() async {
     return await DataBaseProvider.instance.getAllProducts();
  }

  updateProduct(ProductModel product) async {
    return await DataBaseProvider.instance.updateProduct(product);
  }

  createProduct(ProductModel product) async {
    await DataBaseProvider.instance.newProduct(product);
  }

}