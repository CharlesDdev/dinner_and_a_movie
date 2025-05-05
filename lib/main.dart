import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Root widget
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

// Home page with state
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedMood;

  final List<String> moods = [
    'Long Week, Need Easy',
    'Date Night',
    'Comfort Food & Cozy',
    'Feeling Adventurous',
    'Just Background Noise',
  ];

  final Map<String, Map<String, String>> suggestions = {
    'Long Week, Need Easy': {
      'movie': 'The Nice Guys',
      'meal': 'Frozen pizza and garlic knots',
    },
    'Date Night': {
      'movie': 'La La Land',
      'meal': 'Steak with wine and chocolate lava cake',
    },
    'Comfort Food & Cozy': {
      'movie': 'Julie & Julia',
      'meal': 'Mac & cheese with hot tea',
    },
    'Feeling Adventurous': {
      'movie': 'Everything Everywhere All At Once',
      'meal': 'Korean BBQ bowls or sushi',
    },
    'Just Background Noise': {
      'movie': 'The Office (random episode)',
      'meal': 'Leftovers and chips',
    },
  };

  void pickNight() {
    if (selectedMood != null) {
      final suggestion = suggestions[selectedMood]!;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            movie: suggestion['movie']!,
            meal: suggestion['meal']!,
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
            Text(
              'What kind of night is it?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ...moods.map((mood) => RadioListTile<String>(
                  title: Text(mood),
                  value: mood,
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

// Result screen
class ResultScreen extends StatelessWidget {
  final String movie;
  final String meal;

  const ResultScreen({super.key, required this.movie, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tonight’s Plan"),
      ),
      body: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Center(
      child: Card(
        margin: const EdgeInsets.all(24),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Movie', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(movie, style: Theme.of(context).textTheme.bodyLarge),
              const Divider(height: 32),
              Text('Meal', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(meal, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    ),
    const SizedBox(height: 20),
    TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("Start Over"),
    ),
  ],
),
    );
  }
}
// This is a simple Flutter app that suggests a movie and meal based on the user's mood.