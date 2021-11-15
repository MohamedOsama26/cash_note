import 'package:cash_note/logic/models/item_data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  //Function that creates and initializes database
  Future<Database> initializeDb() async {
    return openDatabase(
      join(await getDatabasesPath(), 'cash_note.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE items(id INTEGER PRIMARY KEY AUTOINCREMENT, type VARCHAR(7) , title TEXT , subtitle TEXT NULL , amount REAL , creation_date NUMERIC )');
      },
      version: 1,
    );
  }

  //Function that inserts new items in the table
  Future<void> insertItems(Item item) async {
    final db = await initializeDb();
    await db.insert('items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    // await db.rawQuery('SELECT * FROM items ORDER BY creation_date');
  }

  // Function that reads items from the table
  Future<List<Item>> readItems({sort = ''}) async {
    final db = await initializeDb();

    final List<Map<String, dynamic>> maps = await db.query('items', orderBy: "creation_date $sort");

    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        title: maps[i]['title'],
        subTitle: maps[i]['subtitle'],
        amount: maps[i]['amount'],
        type: maps[i]['type'],
        creationDate: maps[i]['creation_date'],
      );
    });
  }

  //Function that updates items details in database
  Future<void> updateItems(Item item) async {
    final db = await initializeDb();

    await db
        .update('items', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }

  //Function that remove items from database
  Future<void> removeItems(int id) async {
    final db = await initializeDb();

    await db.delete(
      'items',
      where: 'id = ? ',
      whereArgs: [id],
    );
  }
}
