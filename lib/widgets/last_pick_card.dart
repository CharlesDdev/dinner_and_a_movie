import 'package:flutter/material.dart';

class LastPickCard extends StatelessWidget {
  final String movie;
  final String meal;
  final IconData icon;

  const LastPickCard({
    required this.movie,
    required this.meal,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.primary;

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: accentColor),
            const SizedBox(height: 24),
            Text('Movie', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              movie,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Divider(color: theme.dividerColor),
            const SizedBox(height: 24),
            Text('Meal', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              meal,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}