import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'suggestions.dart';
import 'package:provider/provider.dart';
import 'theme_manager.dart'; // already created

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dinner & a Movie',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedMood;

  @override
  void initState() {
    super.initState();
    loadLastMood();
  }

  void loadLastMood() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMood = prefs.getString('lastMood');
    if (savedMood != null) {
      setState(() {
        selectedMood = savedMood;
      });
    }
  }

  void pickNight() async {
    if (selectedMood != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('lastMood', selectedMood!);

      final suggestion = suggestions[selectedMood]!;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            movie: suggestion['movie']!,
            meal: suggestion['meal']!,
            icon: suggestion['icon'],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dinner & a Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selectedMood != null) ...[
              Card(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Icon(
                    suggestions[selectedMood]!['icon'],
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Last Pick'),
                  subtitle: Text(
                    '${suggestions[selectedMood]!['movie']} + ${suggestions[selectedMood]!['meal']}',
                  ),
                  trailing: TextButton(
                    onPressed: pickNight,
                    child: const Text("Replay"),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
            Text(
              'What kind of night is it?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ...moods.map((mood) => RadioListTile<String>(
                  title: Row(
                    children: [
                      Icon(mood['icon']),
                      const SizedBox(width: 10),
                      Text(mood['label']),
                    ],
                  ),
                  value: mood['label'],
                  groupValue: selectedMood,
                  onChanged: (value) {
                    setState(() {
                      selectedMood = value;
                    });
                  },
                )),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: pickNight,
                child: const Text('Pick My Night'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
      appBar: AppBar(
        title: const Text("Tonight’s Plan"),
      ),
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