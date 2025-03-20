
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'transactions.db'),
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE transactions(
              id INTEGER PRIMARY KEY,
              title TEXT,
              category TEXT,
              amount REAL,
              date TEXT,
              isIncome INTEGER
          )''',
        );
      },
      version: 1,
    );
  }
  Future<int> insertTransaction(Map<String, dynamic> transaction) async {
    final db = await this.db;
    return await db.insert('transactions', transaction);
  }

  Future<List<Map<String, dynamic>>> getTransactions() async {
    final db = await this.db;
    return await db.query('transactions');
  }


}
