import 'package:fapp/src/base/DbBaseBean.dart';
import 'package:fapp/src/utils/TextUtil.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbUtils {
  DbUtils._();

  String databasesPath;
  Database database;
  int version = 1;

  static DbUtils dbUtils;

  static DbUtils getInstance() {
    if (dbUtils == null) dbUtils = new DbUtils._();
    return dbUtils;
  }

  Future openDB(String dbName) async {
    if (databasesPath == null || databasesPath.isEmpty) {
      databasesPath = await getDatabasesPath();
    }

    closeDB();

    database = await openDatabase(join(databasesPath , dbName + ".db"), version: version, onCreate: (Database db, int version) async {
      // 用户表
      await db.execute('CREATE TABLE Image (id TEXT PRIMARY KEY, img TEXT, favs INTEGER)');
      // await db.execute(
      //     'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
    }, onUpgrade: (Database db, int oldVersion, int newVersion) {
      // 版本更新方法
    });
  }

  /**
   * @param
   * 插入数据
   */
  Future<void> insertItem<T extends DbBaseBean>(T t) async {
    if (null == database || !database.isOpen) return;
    print("开始插入数据：${t.toJson()}");

    // 插入操作
    await database.insert(
      t.getTableName(),
      t.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// 更新数据
  Future<void> updateItem<T extends DbBaseBean>(
      T t, String key, String value) async {
    if (null == database || !database.isOpen) return null;

    // 更新数据
    await database.update(
      t.getTableName(),
      t.toJson(),
      where: (key + " = ?"),
      whereArgs: [value],
    );
  }

  // 查询数据
  Future<List<T>> queryItems<T extends DbBaseBean>(T t,
      {String key = "", String value = ""}) async {
    if (null == database || !database.isOpen) return null;

    List<Map<String, dynamic>> maps = List();

    // 列表数据
    if (TextUtils.isEmpty(key) || TextUtils.isEmpty(value)) {
      maps = await database.query(t.getTableName());
    } else {
      maps = await database.query(
        t.getTableName(),
        where: (key + " = ?"),
        whereArgs: [value],
      );
    }

    // map转换为List集合
    return List.generate(maps.length, (i) {
      return t.fromJson(maps[i]);
    });
  }



  void closeDB() async {
    if (null != database && database.isOpen) {
      await database.close();
      database = null;
    }
  }
}
