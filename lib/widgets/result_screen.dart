import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_manager.dart'; // Adjust to match your actual path

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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Tonight’s Plan")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Card Display
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: 64, color: theme.colorScheme.primary),
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
              ),

              const SizedBox(height: 32),

              // Start Over Button
              FilledButton.icon(
                icon: const Icon(Icons.restart_alt),
                label: const Text("Start Over"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 24),

              // Theme Toggle Button
              FilledButton.icon(
                icon: const Icon(Icons.brightness_6),
                label: Text(
                  theme.brightness == Brightness.dark ? "Light Mode" : "Dark Mode",
                ),
                onPressed: () {
                  Provider.of<ThemeManager>(context, listen: false).toggleTheme();
                },
              ),

              const SizedBox(height: 16),

              // Accent Color Swatches
              Text("Accent Color", style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAccentDot(context, Colors.deepPurple),
                  _buildAccentDot(context, Colors.teal),
                  _buildAccentDot(context, Colors.pink),
                  _buildAccentDot(context, Colors.orange),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccentDot(BuildContext context, Color color) {
    return GestureDetector(
      onTap: () {
        Provider.of<ThemeManager>(context, listen: false).setAccentColor(color);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).colorScheme.onBackground,
            width: 2,
          ),
        ),
      ),
    );
  }
}