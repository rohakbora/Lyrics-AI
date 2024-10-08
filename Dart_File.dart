import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyrics AI',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: MusicProducer(),
    );
  }
}

class MusicProducer extends StatefulWidget {
  const MusicProducer({super.key});

  @override
  _MusicProducerState createState() => _MusicProducerState();
}

class _MusicProducerState extends State<MusicProducer> {
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _lyricsController = TextEditingController();
  String _lyrics = '';

  // List of predefined genres
  final List<String> _genres = [
    'Pop', 'Rock', 'Jazz', 'Hip-Hop', 'Classical', 'Electronic',
    'Reggae', 'Blues', 'Country', 'Funk', 'Soul', 'Metal',
    'Indie', 'R&B', 'Folk', 'Punk',
  ];

  // Map genres to colors
  final Map<String, Color> _genreColors = {
    'Pop': Colors.pinkAccent,
    'Rock': Colors.grey,
    'Jazz': Colors.blueAccent,
    'Hip-Hop': Colors.deepOrange,
    'Classical': Colors.purpleAccent,
    'Electronic': Colors.cyanAccent,
    'Reggae': Colors.green,
    'Blues': Colors.indigo,
    'Country': Colors.brown,
    'Funk': Colors.yellow,
    'Soul': Colors.deepPurple,
    'Metal': Colors.black,
    'Indie': Colors.teal,
    'R&B': Colors.redAccent,
    'Folk': Colors.orangeAccent,
    'Punk': Colors.lime,
  };

  Color _backgroundColor = Colors.purple; // Default background color

  void _generateLyrics() async {
    String prompt = 'Write a ${_genreController.text} song in ${_languageController.text} based on the following description: ${_descriptionController.text}';

    final response = await http.post(
      Uri.parse('https://lyrics-ai-api.onrender.com/generate-lyrics'), // Update this as needed
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'prompt': prompt}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _lyrics = jsonDecode(response.body)['lyrics'];
        _lyricsController.text = _lyrics; // Update the lyrics text field
      });
    } else {
      setState(() {
        _lyrics = 'Error generating lyrics: ${response.statusCode}';
        _lyricsController.text = _lyrics; // Show error in the text field
      });
    }
  }

  // Function to update background color based on genre
  void _updateBackgroundColor(String genre) {
    setState(() {
      _backgroundColor = _genreColors[genre] ?? Colors.purple; // Default to purple if genre not found
    });
  }

  void _refineLyrics() async {
    String updatedPrompt = 'Refine the following lyrics: "${_lyricsController.text}". Keep the genre as ${_genreController.text} and the description as "${_descriptionController.text}".';

    final response = await http.post(
      Uri.parse('https://lyrics-ai-api.onrender.com/generate-lyrics'), // Update this as needed
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'prompt': updatedPrompt}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _lyrics = jsonDecode(response.body)['lyrics'];
        _lyricsController.text = _lyrics; // Update the lyrics text field with refined lyrics
      });
    } else {
      setState(() {
        _lyrics = 'Error refining lyrics: ${response.statusCode}';
        _lyricsController.text = _lyrics; // Show error in the text field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color textColor;
    Color labelColor;
    bool isBackgroundBlack = _backgroundColor == Colors.black;
    bool isFunk = _backgroundColor == Colors.yellow;
    bool isPunk = _backgroundColor == Colors.lime;
    bool isElec = _backgroundColor == Colors.cyanAccent;
    // Check for background color and set textColor and labelColor accordingly
    if (isBackgroundBlack) {
     textColor = Colors.purple;
     labelColor = Colors.purple;
    } else if (isFunk) {
      textColor = Colors.black87;
      labelColor = Colors.black87;
    } else if (isPunk) {
      textColor = Colors.black87;
      labelColor = Colors.black87;
    } else if (isElec) {
      textColor = Colors.black87;
      labelColor = Colors.black87;
    } else {
      textColor = Colors.white; // Default color if none of the conditions are met
      labelColor = Colors.white; // Default color if none of the conditions are met
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('AI Assisted Music Production'),
        ),
      ),
      body: Container(
        color: _backgroundColor, // No gradient, just a solid background
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _languageController,
                decoration: InputDecoration(
                  labelText: 'Language',
                  labelStyle: TextStyle(color: labelColor),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: textColor),
              ),
              const SizedBox(height: 10),

              // Autocomplete for Genre
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return _genres.where((String option) {
                    return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  _genreController.text = selection;
                  _updateBackgroundColor(selection);
                },
                fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Genre',
                      labelStyle: TextStyle(color: labelColor),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: textColor),
                  );
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Describe the song you would like to produce',
                  labelStyle: TextStyle(color: labelColor),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: textColor),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _generateLyrics,
                child: const Text('Create/Update Lyrics'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _refineLyrics,
                child: const Text('Refine Lyrics'),
              ),
              const SizedBox(height: 30),
              Text('Lyrics', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                 color: Colors.white.withOpacity(0.2), // Background color for the lyrics area
                 borderRadius: BorderRadius.circular(8.0), // Optional: rounded corners
               ),
                padding: const EdgeInsets.all(8.0), // Padding for aesthetics
                constraints: BoxConstraints(
                  minHeight: 300, // Minimum height for the generated lyrics area
                  maxHeight: 300, // Maximum height to allow scrolling
                ),
                child: SingleChildScrollView( // Make the lyrics area scrollable
                  child: Text(
                      _lyricsController.text.isEmpty ? 'Generated lyrics will appear here...' : _lyricsController.text,
                      style: TextStyle(color: textColor),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}