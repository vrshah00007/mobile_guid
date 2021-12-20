import 'dart:io';

import 'package:mobile_guide/Model/mobile.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

class MobileListDBProvider {
  static Database? _database;
  static MobileListDBProvider db = MobileListDBProvider._();

  MobileListDBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'DBMobileList.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE tblMobileList(id INTEGER PRIMARY KEY,Name TEXT,Description TEXT,Brand TEXT,thumbImageURL TEXT,Catid INTEGER,Price TEXT,rating TEXT)",
      );
    });
  }

  void getmobileId(int id,Mobile mobile) async {
    final db = await database;
    int bookquantity = 0;
    List<Map<String, dynamic>> lstbook =
    await db!.query("tblMobileList where Catid ='$id'");
    // print(lstbook[0]['id']);

    int cntbook = lstbook.length;

    if(cntbook >0){
      deletecartItem(id);
    }else {
      insertmobile(mobile);
    }

  }

  insertmobile(Mobile mobile) async {
    final db = await database;
    var res = await db!.insert("tblMobileList", mobile.toMap());
    return res;
  }

  Future<List<Favmobile>> getFavmobileList() async {
    final db = await database;
    List<Map<String, dynamic>> favItemMap = await db!.query("tblMobileList");
    return List.generate(favItemMap.length, (index) {
      return Favmobile(
          id: favItemMap[index]['id'],
          Name: favItemMap[index]['Name'],
          Description: favItemMap[index]['Description'],
          Brand: favItemMap[index]['Brand'],
          thumbImageURL: favItemMap[index]['thumbImageURL'],
          Catid: favItemMap[index]['Catid'],
          Price: favItemMap[index]['Price'],
          rating: favItemMap[index]['rating']);
    });
  }

  Future<void> deletecartItem(int id) async {
    final db = await database;
    await db!.rawDelete("DELETE FROM tblMobileList WHERE Catid = '$id'");
  }
}
