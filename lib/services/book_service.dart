import 'package:sqflite/sqflite.dart';
import '../models/book.dart';
import 'database_helper.dart';

class BookService {
  Future<void> insertBook(Book book, {String? userEmail}) async {
    final db = await DatabaseHelper().database;
    await db.transaction((txn) async {
      await txn.rawInsert(
        "INSERT INTO book(name, price, image, userEmail) VALUES(?, ?, ?, ?)",
        [book.name, book.price, book.image, userEmail],
      );
    });
  }

  Future<List<Book>> fetchBasketBooks() async {
    final db = await DatabaseHelper().database;
    final List<Book> books = [];
    await db.transaction((txn) async {
      final List<Map<String, Object?>> list = await txn.rawQuery("SELECT * FROM book");
      for (var element in list) {
        books.add(
          Book(
            (element["name"] as String),
            (element["price"] as int),
            (element["image"] as String),
          ),
        );
      }
    });
    return books;
  }

  Future<List<Book>> fetchBooksForUser(String userEmail) async {
    final db = await DatabaseHelper().database;
    final List<Map<String, Object?>> list = await db.rawQuery(
      'SELECT * FROM book WHERE userEmail = ?',
      [userEmail],
    );
    return list
        .map((element) => Book(
              (element["name"] as String),
              (element["price"] as int),
              (element["image"] as String),
            ))
        .toList();
  }

  Future<int> deleteBookByName(String name) async {
    final db = await DatabaseHelper().database;
    return db.delete('book', where: 'name = ?', whereArgs: [name]);
  }

  Future<int> clearAll() async {
    final db = await DatabaseHelper().database;
    return db.delete('book');
  }

  /// Delete only one matching book row (not all similar ones)
  Future<int> deleteOne(Book book) async {
    final db = await DatabaseHelper().database;
    // Delete a single row using rowid of the first matching entry
    return await db.rawDelete(
      'DELETE FROM book WHERE rowid = (SELECT rowid FROM book WHERE name = ? AND price = ? AND image = ? LIMIT 1)',
      [book.name, book.price, book.image],
    );
  }

  /// Re-add a deleted book back to remaining inventory (Data.books)
  void reAddToInventory(Book book) {
    for (var i = 0; i < Data.books.length; i++) {
      final b = Data.books[i];
      if (b.name == book.name && b.image == book.image && b.price == book.price) {
        b.quantity++;
        break;
      }
    }
  }
}
