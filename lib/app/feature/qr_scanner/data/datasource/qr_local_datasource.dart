import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as route;

class QrLocalDataSource {
  static const _tableName = 'scanned_codes';

  Database? _db;

  Future<void> init() async {
    if (_db != null) return;

    final dbPath = await getDatabasesPath();
    final path = route.join(dbPath, 'qr_scanner.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            code TEXT NOT NULL,
            scannedAt TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertCode(String code) async {
    await init();
    await _db!.insert(
      _tableName,
      {
        'code': code,
        'scannedAt': DateTime.now().toIso8601String(),
      },
    );
  }
}
