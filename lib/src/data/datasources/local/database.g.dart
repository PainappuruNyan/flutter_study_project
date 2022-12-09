// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FavoritesDao? _favoritesDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FavoritesOffices` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `officeId` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FavoritesPlaces` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `placeId` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FavoritesDao get favoritesDao {
    return _favoritesDaoInstance ??= _$FavoritesDao(database, changeListener);
  }
}

class _$FavoritesDao extends FavoritesDao {
  _$FavoritesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _officeIdInsertionAdapter = InsertionAdapter(
            database,
            'FavoritesOffices',
            (OfficeId item) =>
                <String, Object?>{'id': item.id, 'officeId': item.officeId}),
        _placeIdInsertionAdapter = InsertionAdapter(
            database,
            'FavoritesPlaces',
            (PlaceId item) =>
                <String, Object?>{'id': item.id, 'placeId': item.placeId}),
        _placeIdDeletionAdapter = DeletionAdapter(
            database,
            'FavoritesPlaces',
            ['id'],
            (PlaceId item) =>
                <String, Object?>{'id': item.id, 'placeId': item.placeId});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OfficeId> _officeIdInsertionAdapter;

  final InsertionAdapter<PlaceId> _placeIdInsertionAdapter;

  final DeletionAdapter<PlaceId> _placeIdDeletionAdapter;

  @override
  Future<List<OfficeId>> getAllOffices() async {
    return _queryAdapter.queryList('SELECT * FROM FavoritesOffices',
        mapper: (Map<String, Object?> row) =>
            OfficeId(id: row['id'] as int?, officeId: row['officeId'] as int));
  }

  @override
  Future<void> deleteFavoriteOffice(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM FavoritesOffices WHERE officeId = ?1',
        arguments: [id]);
  }

  @override
  Future<List<PlaceId>> getAllPlaces() async {
    return _queryAdapter.queryList('SELECT * FROM FavoritesPlaces',
        mapper: (Map<String, Object?> row) =>
            PlaceId(row['id'] as int, row['placeId'] as int));
  }

  @override
  Future<void> insertFavoriteOffice(OfficeId office) async {
    await _officeIdInsertionAdapter.insert(office, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertFavoritePlace(PlaceId place) async {
    await _placeIdInsertionAdapter.insert(place, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteFavoritePlace(PlaceId place) async {
    await _placeIdDeletionAdapter.delete(place);
  }
}
