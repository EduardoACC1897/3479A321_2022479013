import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '/models/audit.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'audit_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Crear la tabla de auditoría
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE audit(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        action TEXT NOT NULL
      )
      '''
    );
  }

  // Insertar un registro de auditoría en la base de datos
  Future<void> insertAudit(Audit audit) async {
    final db = await database;
    await db.insert(
      'audit',
      audit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recuperar todas las acciones de auditoría
  Future<List<Audit>> getAudits() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('audit');
    return List.generate(maps.length, (i) {
      return Audit.fromMap(maps[i]);
    });
  }
}
