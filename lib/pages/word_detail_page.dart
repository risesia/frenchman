import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class WordDetailPage extends StatefulWidget {
  final String word;
  final String theme;
  final String pronunciation;
  final String translation;

  WordDetailPage({
    required this.word,
    required this.theme,
    required this.pronunciation,
    required this.translation,
  });

  @override
  WordDetailPageState createState() => WordDetailPageState();
}

class WordDetailPageState extends State<WordDetailPage> {
  late FlutterTts flutterTts;
  bool isFrenchAvailable = false;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _setLanguage();
  }

  Future<void> _setLanguage() async {
    // Fetch available languages
    var languages = await flutterTts.getLanguages;

    // Check if 'fr-FR' (French) is available
    if (languages.contains('fr-FR')) {
      await flutterTts.setLanguage('fr-FR');
      isFrenchAvailable = true;
    } else {
      // Fall back to English if French isn't available
      await flutterTts.setLanguage('en-US');
      isFrenchAvailable = false;
    }

    // Print the languages for debugging purposes
    print("Available languages: $languages");
    print("French available: $isFrenchAvailable");
  }

  Future<void> _speak() async {
    await flutterTts.speak(widget.word);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.word),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromRGBO(227, 251, 255, 1), Color(0xFFFBFDFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Vertical centering
            crossAxisAlignment:
                CrossAxisAlignment.center, // Horizontal centering
            children: [
              Text(
                widget.word,
                textAlign: TextAlign.center, // Align the text center
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                      color: Colors.blue,
                    ),
              ),
              IconButton(
                icon: Icon(Icons.play_circle, size: 40),
                onPressed: _speak,
              ),
              SizedBox(height: 30),
              Text(
                'Pelafalan',
                textAlign: TextAlign.center, // Align the label center
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                widget.pronunciation,
                textAlign: TextAlign.center, // Align the pronunciation center
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
              ),
              SizedBox(height: 16),
              Text(
                'Terjemahan',
                textAlign: TextAlign.center, // Align the label center
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                widget.translation,
                textAlign: TextAlign.center, // Align the translation center
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

enum TtsState { playing, stopped }
