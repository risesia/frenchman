import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import for displaying SVG icons

class LiaisonDetailPage extends StatefulWidget {
  final String liaison;
  final String suara;
  final String description;
  final List<Map<String, String>> examples; // Accept multiple examples

  // Constructor with required parameters
  LiaisonDetailPage({
    required this.liaison,
    required this.suara,
    required this.description,
    required this.examples,
  });

  @override
  State<LiaisonDetailPage> createState() => _LiaisonDetailPageState();
}

class _LiaisonDetailPageState extends State<LiaisonDetailPage> {
  late FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _flutterTts.setLanguage("fr-FR"); // Set the language to French
  }

  Future<void> _playExample(String text) async {
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.liaison),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            // Display the main letter (liaison)
            Center(
              child: Text(
                widget.liaison,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 75,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            // Display suara with a title
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Menghasilkan suara',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  widget.suara,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Display description section
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Deskripsi',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(height: 10),
                Text(
                  widget.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 30),
            // Display examples, pronunciation, and translation in cards
            for (var example in widget.examples)
              _buildLiaisonCard(
                context: context,
                example: example['example']!,
                pronunciation: example['pronunciation']!,
                translation: example['translation']!,
                suara: widget.suara,
              ),
          ],
        ),
      ),
    );
  }

  // Method to build the card for example, pronunciation, and translation
  Widget _buildLiaisonCard({
    required BuildContext context,
    required String example,
    required String pronunciation,
    required String translation,
    required String suara,
  }) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 300,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Contoh',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon related to the example
                    getExampleIcon(example),
                    SizedBox(width: 10), // Space between icon and text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width - 80,
                                  ),
                                  child: Text(
                                    example,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.play_circle),
                                onPressed: () {
                                  _playExample(example);
                                },
                              ),
                            ],
                          ),
                          // Pronunciation text with bolded sounds
                          RichText(
                            text: TextSpan(
                              children: _buildPronunciationTextSpans(
                                pronunciation: pronunciation,
                                boldLetters: [suara],
                                context: context,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            translation,
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

  // Method to bold the matching letters in the pronunciation
  List<TextSpan> _buildPronunciationTextSpans({
    required String pronunciation,
    required List<String> boldLetters,
    required BuildContext context,
  }) {
    List<TextSpan> spans = [];
    for (int i = 0; i < pronunciation.length; i++) {
      final String char = pronunciation[i];

      if (boldLetters.contains(char)) {
        spans.add(
          TextSpan(
            text: char,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: char,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      }
    }
    return spans;
  }

  // Map the example word to an icon (add more examples as needed)
  Widget getExampleIcon(String word) {
    switch (word.toLowerCase()) {
      case 'un ami':
        return SvgPicture.asset(
          'assets/examples/dame.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'bateau':
        return SvgPicture.asset(
          'assets/examples/1F6F6.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      default:
        return Icon(Icons.image_not_supported); // Default icon
    }
  }
}
