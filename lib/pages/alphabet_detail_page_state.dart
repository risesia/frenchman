import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:frenchman/pages/alphabet_detail_page.dart';

class AlphabetDetailPageState extends State<AlphabetDetailPage> {
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();

    // Optionally configure the TTS language for French pronunciation
    flutterTts.setLanguage('fr-FR'); // Set to French
  }

  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromRGBO(227, 251, 255, 1), Color(0xFFFBFDFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: Text('Details: ${widget.letter}'),
        backgroundColor: Color(0xFF007ae2), // Custom color or gradient
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Letter display at the top
            Text(
              widget.letter,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Play button for pronunciation
            IconButton(
              icon: Icon(Icons.play_circle, size: 50),
              onPressed: () {
                _speak(
                    widget.audioUrl); // Play the pronunciation using audioUrl
              },
            ),
            SizedBox(height: 30),
            // Example 1 section
            _buildExampleSection(
              exampleText: widget.example1,
              ipaText: widget.ipa1,
              translationText: widget.translation1,
              playExample: () => _speak(widget.example1),
              exampleTitle: 'Contoh 1',
            ),
            SizedBox(height: 20),
            // Example 2 section
            _buildExampleSection(
              exampleText: widget.example2,
              ipaText: widget.ipa2,
              translationText: widget.translation2,
              playExample: () => _speak(widget.example2),
              exampleTitle: 'Contoh 2',
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build the example section
// Widget to build the example section with a card and dynamic icon
  Widget _buildExampleSection({
    required String exampleText,
    required String ipaText,
    required String translationText,
    required VoidCallback playExample,
    required String exampleTitle,
  }) {
    // Map the example word to an icon (add more examples as needed)
    IconData getExampleIcon(String word) {
      switch (word.toLowerCase()) {
        case 'avion':
          return Icons.airplanemode_active; // Plane icon for "avion"
        case 'chat':
          return Icons.pets; // Pet icon for "chat" (cat)
        case 'maison':
          return Icons.house; // House icon for "maison" (house)
        case 'maman':
          return Icons.elderly_woman;
        case 'papa':
          return Icons.elderly;
        default:
          return Icons.volume_up; // Default icon for unknown examples
      }
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 300, // Set the maximum width
          minWidth: 250, // Optionally, set a minimum width
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          elevation: 4, // Elevation for shadow effect
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    exampleTitle,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon related to the example
                    Icon(
                      getExampleIcon(exampleText),
                      size: 75,
                      color: Colors.blue, // Set the icon color
                    ),
                    SizedBox(width: 10), // Space between icon and text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                exampleText,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              IconButton(
                                icon: Icon(Icons.play_circle),
                                onPressed: playExample,
                              ),
                            ],
                          ),
                          Text(
                            ipaText,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            translationText,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
}
