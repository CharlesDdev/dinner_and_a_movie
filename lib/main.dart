import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'suggestions.dart';
import 'theme/theme_manager.dart';
import 'widgets/last_pick_card.dart';
import 'package:dinner_and_a_movie/widgets/result_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp(
      title: 'Dinner & a Movie',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: themeManager.accentColor,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeManager.accentColor,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          foregroundColor: themeManager.accentColor,
        ),
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeManager.accentColor,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: themeManager.themeMode,
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
  Map<String, dynamic>? lastPick;

  @override
  void initState() {
    super.initState();
    loadLastMood();
  }

  void loadLastMood() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMood = prefs.getString('lastMood');
    if (savedMood != null && suggestions.containsKey(savedMood)) {
      setState(() {
        selectedMood = savedMood;
        lastPick = suggestions[savedMood];
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
    final themeManager = Provider.of<ThemeManager>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Dinner & a Movie')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (lastPick != null) ...[
              LastPickCard(lastPick: lastPick!),
              const SizedBox(height: 16),
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