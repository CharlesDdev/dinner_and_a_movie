import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String movie;
  final String meal;
  final IconData icon;

  const ResultScreen({
    super.key,
    required this.movie,
    required this.meal,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tonight’s Plan")),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 64, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 16),
                Text('Movie', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(movie, style: Theme.of(context).textTheme.bodyLarge),
                const Divider(height: 32),
                Text('Meal', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(meal, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Start Over"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}