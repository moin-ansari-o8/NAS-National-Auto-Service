import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'garage_inventory.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE bike_details(bike_id INTEGER PRIMARY KEY AUTOINCREMENT, bike_name TEXT)',
        );
        await db.execute(
          'CREATE TABLE spare_part_details(spare_part_id INTEGER PRIMARY KEY AUTOINCREMENT, spare_part_name TEXT, spare_part_price REAL, spare_part_quantity INTEGER, bike_id INTEGER)',
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> getBikes() async {
    final db = await database;
    return await db.query('bike_details');
  }

  Future<void> addBike(String bikeName) async {
    final db = await database;
    await db.insert(
      'bike_details',
      {'bike_name': bikeName},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<Map<String, dynamic>>> getSparePartsByBikeId(int bikeId) async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'garage_inventory.db'),
    );

    return await database.query(
      'spare_part_details',
      where: 'bike_id = ?',
      whereArgs: [bikeId],
    );
  }
}
