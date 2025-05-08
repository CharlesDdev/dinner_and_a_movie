import 'package:flutter/material.dart';

class LastPickCard extends StatelessWidget {
  final Map<String, dynamic> lastPick;

  const LastPickCard({required this.lastPick, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Pick',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text('Movie: ${lastPick['movie']}'),
            Text('Meal: ${lastPick['meal']}'),
          ],
        ),
      ),
    );
  }
}