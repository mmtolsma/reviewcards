import 'package:path/path.dart';
import 'package:review_cards/models/review-card.dart';
import 'package:sqflite/sqflite.dart';

class RCDatabase {
  static Future<Database> database;

  ////////////////////////////////////////////////
  /// Open DB
  ////////////////////////////////////////////////
  static openDB() async {
    database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly constructed
      join(await getDatabasesPath(), 'rc_database.db'),

      // When the database is first created, create a table to store review_cards.
      // Auto incrementing the primary key.
      // onCreate: (db, version) {
      //   return db.execute(
      //     '''CREATE TABLE review_cards(
      //       id INTEGER PRIMARY KEY AUTOINCREMENT,
      //       subject TEXT,
      //       question TEXT,
      //       answer TEXT
      //     )''',
      //   );
      // },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 15,
    );
  }

  ////////////////////////////////////////////////
  /// Insert Card
  ////////////////////////////////////////////////
  static Future<void> insertRC(ReviewCard rc) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the review card into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db
        .insert('review_cards', rc.toMap())
        .whenComplete(() => print("card added"));
  }

  ////////////////////////////////////////////////
  /// Fetch ALL Cards
  ////////////////////////////////////////////////
  static Future<List<ReviewCard>> fetchAllCards() async {
    // Open database
    var client = await database;

    // Get table from database
    var res = await client.query('review_cards');

    if (res.isNotEmpty) {
      var cards = res.map((cardMap) => ReviewCard.fromDb(cardMap)).toList();
      cards.forEach((card) {
        print(card);
      });
      return cards;
    }
    return [];
  }

  ////////////////////////////////////////////////
  /// Fetch all subjects for the subject-viewer page
  ////////////////////////////////////////////////
  static Future<List<String>> fetchSubjectCards() async {
    // Open database
    var client = await database;

    // Get table from database
    var res = await client.rawQuery('SELECT subject FROM review_cards');

    if (res.isNotEmpty) {
      var subjects =
          res.map((subject) => subject['subject'].toString()).toList();
      return subjects;
    }
    return [];
  }

  ////////////////////////////////////////////////
  /// Update Database to add subject table
  ////////////////////////////////////////////////
  static addNewTopic(String tableName) async {
    final Database db = await database;

    db
        .execute(
          '''CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            question TEXT,
            answer TEXT
          )''',
        )
        .whenComplete(
          () => print("$tableName created!"),
        )
        .catchError((error) {
          print("Could not add $tableName");
        });
  }

  ////////////////////////////////////////////////
  /// Delete Entire Table
  ////////////////////////////////////////////////
  static deleteTable() async {
    final db = await database;
    db.delete("review_cards").whenComplete(() => print("table_deleted"));
  }
}
