import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

 // Closing brace for _MyHomePageState class

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dinner & a Movie',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(), // No more title passed here
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

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Tonight's Vibe"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSuggestionCard(
                movie: suggestion['movie']!,
                meal: suggestion['meal']!,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Nice!'),
            )
          ],
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
            ...moods.map((mood) => RadioListTile(
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
Widget _buildSuggestionCard({required String movie, required String meal}) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Movie Recommendation',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(movie, style: TextStyle(fontSize: 14)),
          const Divider(),
          Text(
            'Meal Idea',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(meal, style: TextStyle(fontSize: 14)),
        ],
      ),
    ),
  );
}