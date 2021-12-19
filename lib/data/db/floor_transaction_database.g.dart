// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_transaction_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorFloorTransactionDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorTransactionDatabaseBuilder databaseBuilder(String name) =>
      _$FloorTransactionDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorTransactionDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FloorTransactionDatabaseBuilder(null);
}

class _$FloorTransactionDatabaseBuilder {
  _$FloorTransactionDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$FloorTransactionDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FloorTransactionDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FloorTransactionDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FloorTransactionDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FloorTransactionDatabase extends FloorTransactionDatabase {
  _$FloorTransactionDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FloorTransactionDao? _transactionDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `transaction_table` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `income` INTEGER NOT NULL, `amount` REAL NOT NULL, `date` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FloorTransactionDao get transactionDao {
    return _transactionDaoInstance ??=
        _$FloorTransactionDao(database, changeListener);
  }
}

class _$FloorTransactionDao extends FloorTransactionDao {
  _$FloorTransactionDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _transactionInsertionAdapter = InsertionAdapter(
            database,
            'transaction_table',
            (Transaction item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'income': item.income ? 1 : 0,
                  'amount': item.amount,
                  'date': item.date
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Transaction> _transactionInsertionAdapter;

  @override
  Stream<List<Transaction>> getAllTransactions() {
    return _queryAdapter.queryListStream('SELECT * FROM transaction_table',
        mapper: (Map<String, Object?> row) => Transaction(
            id: row['id'] as int?,
            title: row['title'] as String,
            income: (row['income'] as int) != 0,
            amount: row['amount'] as double,
            date: row['date'] as String),
        queryableName: 'transaction_table',
        isView: false);
  }

  @override
  Future<Transaction?> getTransaction(int id) async {
    return _queryAdapter.query('SELECT * FROM transaction_table WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Transaction(
            id: row['id'] as int?,
            title: row['title'] as String,
            income: (row['income'] as int) != 0,
            amount: row['amount'] as double,
            date: row['date'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deleteTransaction(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM transaction_table WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> upsertTransaction(Transaction transaction) async {
    await _transactionInsertionAdapter.insert(
        transaction, OnConflictStrategy.replace);
  }
}
