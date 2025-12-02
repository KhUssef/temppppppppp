import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book.dart';

class BasketService {
  static const _kBasketKey = 'basket_books';

  Future<void> addToBasket(Book book) async {
    final sp = await SharedPreferences.getInstance();
    final existing = sp.getStringList(_kBasketKey) ?? <String>[];
    final encoded = jsonEncode({
      'name': book.name,
      'image': book.image,
      'price': book.price, // int in current model
    });
    existing.add(encoded);
    await sp.setStringList(_kBasketKey, existing);
  }

  Future<List<Book>> getBasket() async {
    final sp = await SharedPreferences.getInstance();
    final items = sp.getStringList(_kBasketKey) ?? <String>[];
    return items.map((s) {
      final m = jsonDecode(s) as Map<String, dynamic>;
      // Book has positional constructor: Book(name, price, image)
      return Book(
        m['name'] as String,
        (m['price'] as num).toInt(),
        m['image'] as String,
      );
    }).toList();
  }

  Future<void> clearBasket() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kBasketKey);
  }
}
