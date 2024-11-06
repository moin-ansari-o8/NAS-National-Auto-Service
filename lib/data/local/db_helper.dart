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

  // Get all bikes from the 'bike_details' table
  Future<List<Map<String, dynamic>>> getBikes() async {
    final db = await database;
    return await db.query('bike_details');
  }

  // Add a new bike to the 'bike_details' table
  Future<void> addBike(String bikeName) async {
    final db = await database;
    await db.insert(
      'bike_details',
      {'bike_name': bikeName},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update the bike name in the 'bike_details' table
  Future<void> updateBike(int bikeId, String newBikeName) async {
    final db = await database;
    await db.update(
      'bike_details',
      {'bike_name': newBikeName},
      where: 'bike_id = ?',
      whereArgs: [bikeId],
    );
  }

  // Delete a bike from the 'bike_details' table
  Future<void> deleteBike(int bikeId) async {
    final db = await database;
    await db.delete(
      'bike_details',
      where: 'bike_id = ?',
      whereArgs: [bikeId],
    );
  }

  // Get all spare parts associated with a specific bike (by bike_id)
  Future<List<Map<String, dynamic>>> getSparePartsByBikeId(int bikeId) async {
    final db = await database;
    return await db.query(
      'spare_part_details',
      where: 'bike_id = ?',
      whereArgs: [bikeId],
    );
  }
}
