import 'package:flutter/material.dart';
import 'package:flutter_application_1/quote_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Intro Screen',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuoteScreen(method: FetchMethod.http)),
                );
              },
              child: const Text('View Quotes (HTTP)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuoteScreen(method: FetchMethod.dio)),
                );
              },
              child: const Text('View Quotes (Dio)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuoteScreen(method: FetchMethod.retrofit)),
                );
              },
              child: const Text('View Quotes (Retrofit)'),
            ),
          ],
        ),
      ),
    );
  }
}