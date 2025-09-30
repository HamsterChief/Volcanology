import 'package:volcanologyproject/Models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io'; // <-- Add this line

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Volcanology.db";

  static Future<Database> getDB() async {
    // Create a 'data' folder in your project if it doesn't exist
    final dbPath = join(
      // This points to your project directory
      Directory.current.path,
      'data',
      _dbName,
    );

    // Ensure the 'data' directory exists
    await Directory(
      join(Directory.current.path, 'data'),
    ).create(recursive: true);

    return openDatabase(
      dbPath,
      onCreate: (db, version) async {
        // Volcano table
        await db.execute('''
          CREATE TABLE Volcano(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            location TEXT NOT NULL,
            lastEruption TEXT
          );
        ''');

        // Event table
        await db.execute('''
          CREATE TABLE Event(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            volcanoId INTEGER NOT NULL,
            name TEXT NOT NULL,
            date TEXT NOT NULL,
            description TEXT NOT NULL,
            FOREIGN KEY (volcanoId) REFERENCES Volcano(id)
          );
        ''');

        // Comment table
        await db.execute('''
          CREATE TABLE Comment(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            eventId INTEGER NOT NULL,
            createdBy TEXT NOT NULL,
            content TEXT NOT NULL,
            date TEXT NOT NULL,
            FOREIGN KEY (eventId) REFERENCES Event(id)
          );
        ''');

        // User table
        await db.execute('''
          CREATE TABLE User(
            username TEXT PRIMARY KEY,
            email TEXT NOT NULL,
            admin INTEGER NOT NULL
          );
        ''');
      },
      version: _version,
    );
  }

  static Future<List<Comment>> getCommentsForEvent(int eventId) async {
    final db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'Comment',
      where: 'eventId = ?',
      whereArgs: [eventId],
    );
    return List.generate(maps.length, (i) {
      return Comment(
        createdBy: maps[i]['createdBy'],
        content: maps[i]['content'],
        date: maps[i]['date'],
      );
    });
  }
}
