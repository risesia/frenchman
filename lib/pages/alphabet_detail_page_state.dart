import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        title: Text(widget.letter),
        backgroundColor: Color(0xFF007ae2), // Custom color or gradient
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Letter display at the top
            SizedBox(height: 30),
            Text(
              widget.letter,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
              textAlign: TextAlign.center,
            ),
            // SizedBox(height: 5),
            // Play button for pronunciation
            IconButton(
              icon: Icon(Icons.play_circle, size: 50),
              onPressed: () {
                _speak(
                    widget.audioUrl); // Play the pronunciation using audioUrl
              },
            ),
            SizedBox(height: 50),
            // Example 1 section
            _buildExampleSection(
              exampleText: widget.example1,
              ipaText: widget.ipa1,
              translationText: widget.translation1,
              playExample: () => _speak(widget.example1),
              exampleTitle: 'Contoh 1',
              boldLetters: widget.boldLetters, // Pass boldLetter here
            ),
            SizedBox(height: 20),
            // Example 2 section
            _buildExampleSection(
              exampleText: widget.example2,
              ipaText: widget.ipa2,
              translationText: widget.translation2,
              playExample: () => _speak(widget.example2),
              exampleTitle: 'Contoh 2',
              boldLetters: widget.boldLetters,
            ),
          ],
        ),
      ),
    );
  }

  // Map the example word to an icon (add more examples as needed)
  Widget getExampleIcon(String word) {
    switch (word.toLowerCase()) {
      case 'banane':
        return SvgPicture.asset(
          'assets/examples/1F34C.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'bateau':
        return SvgPicture.asset(
          'assets/examples/1F6F6.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'dame':
        return SvgPicture.asset(
          'assets/examples/dame.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'radio':
        return SvgPicture.asset(
          'assets/examples/radio.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'famille':
        return SvgPicture.asset(
          'assets/examples/famille.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'fille':
        return SvgPicture.asset(
          'assets/examples/dame.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'garçon':
        return SvgPicture.asset(
          'assets/examples/garçon.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'goût':
        return SvgPicture.asset(
          'assets/examples/goût.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'carte':
        return SvgPicture.asset(
          'assets/examples/carte.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'coucou':
        return SvgPicture.asset(
          'assets/examples/coucou.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'chat':
        return SvgPicture.asset(
          'assets/examples/chat.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'chou':
        return SvgPicture.asset(
          'assets/examples/chou.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'lampe':
        return SvgPicture.asset(
          'assets/examples/lampe.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'long':
        return SvgPicture.asset(
          'assets/examples/long.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'mais':
        return SvgPicture.asset(
          'assets/examples/mais.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'maman':
        return SvgPicture.asset(
          'assets/examples/dame.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'neige':
        return SvgPicture.asset(
          'assets/examples/neige.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'nez':
        return SvgPicture.asset(
          'assets/examples/nez.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'papa':
        return SvgPicture.asset(
          'assets/examples/papa.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'pomme':
        return SvgPicture.asset(
          'assets/examples/pomme.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'rouge':
        return SvgPicture.asset(
          'assets/examples/rouge.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'rire':
        return SvgPicture.asset(
          'assets/examples/rire.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'face':
        return SvgPicture.asset(
          'assets/examples/papa.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'soleil':
        return SvgPicture.asset(
          'assets/examples/sun.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'table':
        return SvgPicture.asset(
          'assets/examples/table.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'tout':
        return SvgPicture.asset(
          'assets/examples/tout.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'vive':
        return SvgPicture.asset(
          'assets/examples/vive.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'gaz':
        return SvgPicture.asset(
          'assets/examples/gaz.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'zoo':
        return SvgPicture.asset(
          'assets/examples/zoo.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'vase':
        return SvgPicture.asset(
          'assets/examples/vase.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'gentil':
        return SvgPicture.asset(
          'assets/examples/tout.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'journal':
        return SvgPicture.asset(
          'assets/examples/journal.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'jogging':
        return SvgPicture.asset(
          'assets/examples/jogging.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'camping':
        return SvgPicture.asset(
          'assets/examples/camping.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'gagner':
        return SvgPicture.asset(
          'assets/examples/tout.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'montagne':
        return SvgPicture.asset(
          'assets/examples/montage.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'travail':
        return SvgPicture.asset(
          'assets/examples/travail.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'bois':
        return SvgPicture.asset(
          'assets/examples/bois.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'oui':
        return SvgPicture.asset(
          'assets/examples/mais.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'huile':
        return SvgPicture.asset(
          'assets/examples/huile.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      case 'lune':
        return SvgPicture.asset(
          'assets/examples/lune.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
      default:
        return SvgPicture.asset(
          'assets/examples/1F34C.svg', // Path to your SVG file
          width: 75,
          height: 75,
        );
    }
  }

  // Widget to build the example section
// Widget to build the example section with a card and dynamic icon
  Widget _buildExampleSection({
    required String exampleText,
    required String ipaText,
    required String translationText,
    required VoidCallback playExample,
    required String exampleTitle,
    required List<String>
        boldLetters, // Optional parameter to specify the letter to bold
  }) {
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
                    getExampleIcon(exampleText),
                    SizedBox(width: 10), // Space between icon and text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Use RichText to bold the specified letter
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width -
                                            80, // Adjust for IconButton width
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      children: _buildTextSpans(
                                        exampleText: exampleText,
                                        boldLetters: boldLetters,
                                        context: context,
                                      ),
                                    ),
                                  ),
                                ),
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

// Helper method to create TextSpan for bolding specific letters
List<TextSpan> _buildTextSpans({
  required String exampleText,
  required List<String>? boldLetters, // Now accepts a list of bold letters
  required BuildContext context,
}) {
  List<TextSpan> spans = [];

  if (boldLetters == null || boldLetters.isEmpty) {
    spans.add(TextSpan(
        text: exampleText, style: Theme.of(context).textTheme.headlineLarge));
    return spans;
  }

  int startIndex = 0;
  while (startIndex < exampleText.length) {
    int? nextBoldStartIndex;
    String? boldLetter;

    // Find the earliest occurrence of any bold letter
    for (String letter in boldLetters) {
      final int index = exampleText.indexOf(letter, startIndex);
      if (index != -1 &&
          (nextBoldStartIndex == null || index < nextBoldStartIndex)) {
        nextBoldStartIndex = index;
        boldLetter = letter;
      }
    }

    // If no bold letters are found, add the rest of the text
    if (nextBoldStartIndex == null) {
      spans.add(TextSpan(
        text: exampleText.substring(startIndex),
        style: Theme.of(context).textTheme.headlineLarge,
      ));
      break;
    }

    // Add text before the bold letter
    if (nextBoldStartIndex > startIndex) {
      spans.add(TextSpan(
        text: exampleText.substring(startIndex, nextBoldStartIndex),
        style: Theme.of(context).textTheme.headlineLarge,
      ));
    }

    // Add the bold letter(s)
    spans.add(TextSpan(
      text: boldLetter,
      style: Theme.of(context)
          .textTheme
          .headlineLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    ));

    // Move startIndex past the bolded text
    startIndex = nextBoldStartIndex + boldLetter!.length;
  }

  return spans;
}
