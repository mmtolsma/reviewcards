import 'package:path/path.dart';
import 'package:review_cards/models/review-card.dart';
import 'package:sqflite/sqflite.dart';

class RCDatabase {
  // Only one reference to the database
  static Database _database;

  static final _dbName = 'rc_database.db';
  static final _dbVersion = 1;
  static final _topicsTableName = 'topics';
  static final _cardsTableName = 'cards';

  // Singleton class
  RCDatabase._privateConstructor();
  static final RCDatabase instance = RCDatabase._privateConstructor();

  // Fetch db or instantiate it for the first time
  Future<Database> get database async {
    // If there's an existing db, return it.
    if (_database != null) return _database;

    // Else, initialise the db then return.
    _database = await _initDatabase();
    return _database;
  }

  // This is to enable the use of foreign keys
  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // Create the tables needed to store user review card data
  static void _onCreate(Database db, int newVersion) async {
    // Table to store the topics
    await db.execute(
      '''CREATE TABLE $_topicsTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT
          )''',
    );

    // Table to store the cards, linked to topics via foreign key
    await db.execute(
      '''CREATE TABLE $_cardsTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            question TEXT,
            answer TEXT,
            FOREIGN KEY (topicId) REFERENCES $_topicsTableName(id) ON DELETE NO ACTION ON UPDATE NO ACTION
          )''',
    );
  }

  // Initialising the database
  _initDatabase() async {
    return await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly constructed.
      // getDatabasesPath = default database directory on Android.
      join(await getDatabasesPath(), _dbName),

      onConfigure: _onConfigure,

      // When the database is first created, create a table to store review_cards.
      // Auto incrementing the primary key.
      onCreate: _onCreate,
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: _dbVersion,
    );
  }

  ////////////////////////////////////////////////
  /// Insert new card
  ////////////////////////////////////////////////
  static Future<void> insertCard(ReviewCard rc) async {
    // Get a reference to the database.
    Database db = await instance.database;

    // Insert the review card into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db
        .insert('$_cardsTableName', rc.toMap())
        .whenComplete(() => print("card added"));
  }

  ////////////////////////////////////////////////
  /// Insert new topic
  ////////////////////////////////////////////////
  // static insertTopic(Topics topic) async {
  //   Database db = await instance.database;

  //   await db
  //       .insert('$_cardsTableName', topic.toMap())
  //       .whenComplete(() => print("card added"));
  // }

  ////////////////////////////////////////////////
  /// Delete Entire Table
  ////////////////////////////////////////////////
  static deleteTable() async {
    final db = await _database;
    db.delete("$_dbName").whenComplete(() => print("table_deleted"));
  }
}
