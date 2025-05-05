import 'package:flutter/material.dart';

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