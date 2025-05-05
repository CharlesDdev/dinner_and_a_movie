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

  final List<Map<String, dynamic>> moods = [
  {
    'label': 'Long Week, Need Easy',
    'icon': Icons.weekend,
  },
  {
    'label': 'Date Night',
    'icon': Icons.favorite,
  },
  {
    'label': 'Comfort Food & Cozy',
    'icon': Icons.local_cafe,
  },
  {
    'label': 'Feeling Adventurous',
    'icon': Icons.explore,
  },
  {
    'label': 'Just Background Noise',
    'icon': Icons.music_note,
  },
];

  final Map<String, Map<String, dynamic>> suggestions = {
  'Long Week, Need Easy': {
    'movie': 'The Nice Guys',
    'meal': 'Frozen pizza and garlic knots',
    'icon': Icons.weekend,
  },
  'Date Night': {
    'movie': 'La La Land',
    'meal': 'Steak with wine and chocolate lava cake',
    'icon': Icons.favorite,
  },
  'Comfort Food & Cozy': {
    'movie': 'Julie & Julia',
    'meal': 'Mac & cheese with hot tea',
    'icon': Icons.local_cafe,
  },
  'Feeling Adventurous': {
    'movie': 'Everything Everywhere All At Once',
    'meal': 'Korean BBQ bowls or sushi',
    'icon': Icons.travel_explore,
  },
  'Just Background Noise': {
    'movie': 'The Office (random episode)',
    'meal': 'Leftovers and chips',
    'icon': Icons.tv,
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
          icon: suggestion['icon'], // include the icon!
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

// Result screen
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
// This is a simple Flutter app that suggests a movie and meal based on the user's mood.