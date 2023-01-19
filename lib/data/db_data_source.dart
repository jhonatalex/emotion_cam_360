import 'package:emotion_cam_360/entities/event.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbDataSource {
  static Future<DbDataSource> init() async {
    final aux = DbDataSource();
    await aux._init();
    return aux;
  }

  late final Database db;

  Future<void> _init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'emotion.db');
    db = await openDatabase(path, version: 2,
        onCreate: (Database newDb, int version) async {
      await newDb.execute('''
          CREATE TABLE evento
          (
            id TEXT PRIMARY KEY ,
            name TEXT,
            overlay TEXT,
            music TEXT,
            videos TEXT
          )
        ''');
    });
  }

  Future<int> save(EventEntity toSave) {
    return db.insert(
      'evento',
      toSave.toMapForDb(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> delete(EventEntity toDelete) {
    return db.delete(
      'evento',
      where: 'name = ? AND id = ?',
      whereArgs: [toDelete.name, toDelete.id],
    );
  }

  Future<int> getEventDb(EventEntity toDelete) {
    return db.delete(
      'evento',
      where: 'name = ? AND id = ?',
      whereArgs: [toDelete.name, toDelete.id],
    );
  }

  Future<EventEntity> getLastEvent() async {
    const query =
        'SELECT evento.id, evento.name, evento.overlay, evento.music, evento.videos FROM evento';
    final queryResult = await db.rawQuery(query);
    return queryResult.map((e) => EventEntity.fromMap(e)).last;
  }

  Future<List<EventEntity>> getAllEvents() async {
    const query =
        'SELECT evento.id, evento.name, evento.overlay, evento.music, evento.videos FROM evento';
    final queryResult = await db.rawQuery(query);
    return queryResult.map((e) => EventEntity.fromMap(e)).toList();
  }
}
