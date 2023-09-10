import 'dart:io';
import 'package:flutter_storage/database/constant.dart';
import 'package:flutter_storage/model/product_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class ProductDatabase {
  // create database
  Future<Database> initProductDatabase() async {
    final Directory tempDir = await getTemporaryDirectory();
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'procducts.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE $productTable(id INTEGER PRIMARY KEY, name TEXT,price REAL)',
        );
      },
      version: 1,
    );
  }

  // insert database
  Future<void> insertProduct(ProductModel pro) async {
    var db = await initProductDatabase();
    await db.insert(productTable, pro.toMap());
    print('Add success');
  }

  // Read data
  Future<List<ProductModel>> getProducts() async {
    var db = await initProductDatabase();
    List<Map<String, dynamic>> result = await db.query(productTable);
    return result.map((e) => ProductModel.fromMap(e)).toList();
  }
  // update database

  // Delete Database
}
