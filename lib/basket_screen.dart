import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/book.dart';
import 'package:flutter_application_1/services/book_service.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              // Re-add all basket items back to inventory, then clear DB
              final items = await BookService().fetchBasketBooks();
              for (final b in items) {
                BookService().reAddToInventory(b);
              }
              await BookService().clearAll();
              if (mounted) {
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Basket cleared and stock restored.')),
                );
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Book>>(
        future: BookService().fetchBasketBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erreur : ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('Basket is empty'));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final b = items[index];
              return ListTile(
                leading: Image.asset(b.image, width: 48, height: 48, fit: BoxFit.cover),
                title: Text(b.name),
                subtitle: Text('${b.price} TND'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () async {
                    // Delete only one matching row, and restore inventory quantity
                    await BookService().deleteOne(b);
                    BookService().reAddToInventory(b);
                    setState(() {});
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
