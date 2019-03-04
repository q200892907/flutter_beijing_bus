import '../bean/collect_bus_bean.dart';
import 'package:sqflite/sqflite.dart';
export '../bean/collect_bus_bean.dart';

class SqliteUtil {
  // 工厂模式
  factory SqliteUtil() => _getInstance();

  static SqliteUtil get instance => _getInstance();
  static SqliteUtil _instance;

  SqliteUtil._internal() {
    // 初始化
    _initDb();
  }

  static SqliteUtil _getInstance() {
    if (_instance == null) {
      _instance = new SqliteUtil._internal();
    }
    return _instance;
  }

  String _dbPath;
  CollectProvider collectProvider;

  Future _initDb() async {
    var databasesPath = await getDatabasesPath();
    _dbPath = databasesPath + '/bus.db';
    print("数据库位置：" + _dbPath);
    collectProvider = CollectProvider();
    openCollect();
  }

  Future openCollect() async {
    collectProvider.open(_dbPath);
  }

  Future closeCollect() async {
    collectProvider.close();
  }
}

class CollectProvider {
  static const String TABLE_COLLECT = 'collect';
  static const String ID = '_id';
  static const String BUS_ID = 'busId';
  static const String BUS_NAME = 'busName';
  static const String STATION_ID = 'stationId';
  static const String STATION_NAME = 'stationName';
  static const String START = 'start';
  static const String END = 'end';
  static const String HOME = 'home';

  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
create table $TABLE_COLLECT ( 
  $ID integer primary key autoincrement, 
  $BUS_ID text not null,
  $BUS_NAME text not null,
  $STATION_ID text not null,
  $STATION_NAME text not null,
  $START text not null,
  $END text not null,
  $HOME integer not null)
''');
    });
  }

  Future<CollectBusBean> insert(CollectBusBean bus) async {
    bus.id = await db.insert(TABLE_COLLECT, bus.toJson());
    return bus;
  }

  Future<List<CollectBusBean>> queryAll([bool isProminent = false]) async {
    List<Map> maps;
    if (isProminent) {
      maps = await db.query(TABLE_COLLECT, where: '$HOME = ?', whereArgs: [CollectType.PROMINENT.index]);
    } else {
      maps = await db.query(TABLE_COLLECT);
    }
    if (maps.length > 0) {
      return maps.map((item) {
        return CollectBusBean.fromJson(item);
      }).toList();
    }
    return [];
  }

  Future<CollectBusBean> query(String busId, String stationId) async {
    List<Map> maps = await db.query(TABLE_COLLECT, where: '$BUS_ID = ? and $STATION_ID = ?', whereArgs: [busId, stationId]);
    if (maps.length > 0) {
      return CollectBusBean.fromJson(maps.first);
    }
    return null;
  }

  Future<int> delete(String busId, String stationId) async {
    return await db.delete(TABLE_COLLECT, where: '$BUS_ID = ? and $STATION_ID = ?', whereArgs: [busId, stationId]);
  }

  Future<int> update(CollectBusBean bus) async {
    Map<String, dynamic> map = Map();
    map[HOME] = bus.home;
    return await db.update(TABLE_COLLECT, map, where: '$BUS_ID = ? and $STATION_ID = ?', whereArgs: [bus.busId, bus.stationId]);
  }

  Future close() async => db.close();
}
