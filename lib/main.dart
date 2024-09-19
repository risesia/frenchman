import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'alphabet_data.dart';
import 'liaisons_data.dart';
import 'basic_word_data.dart';

void main() {
  runApp(MyApp());
}

// TODO:
// homepage,
// gambar untuk example,
// tambah data baru,
// redesign, include warna merah,
// contoh yang bold di docs, tetap bold di app
// liason ditandai dengan warna yangsama, berdasarkan uruf bold, ditambahkan keterangan
// pengelompokan liaison berdasarkan pertemuan huruf
// pengelompokan kalimat dasar berdasarkan tema

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'French Alphabet Dictionary',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 194, 226)),
          scaffoldBackgroundColor:
              Color.fromARGB(255, 251, 253, 255), // Set app background color
          cardColor: Color(0xff317480), // Set card color
          textTheme: TextTheme(
            headlineLarge: TextStyle(
                color: Color(0xff050608)), // Set text color for large headlines
            headlineSmall: TextStyle(
                color:
                    Color(0xff050608)), // Set text color for smaller headlines
            bodyMedium: TextStyle(
                color: Color(0xff050608)), // Set text color for medium text
            titleLarge: TextStyle(
                color: Color(0xff050608)), // Set text color for title text
            titleMedium: TextStyle(
                color: Color(0xff050608)), // Set text color for subtitle text
          ),
        ),
        home: MyHomePage(), // Set MyHomePage as the default page
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  void navigateToAlphabetPage(
      BuildContext context, String letter, String category) {
    Map<String, String> alphabetData;

    // Use category to determine which list to search
    switch (category) {
      case 'Consonants':
        alphabetData =
            consonants.firstWhere((element) => element['letter'] == letter);
      case 'Semi-Consonants':
        alphabetData =
            semiConsonants.firstWhere((element) => element['letter'] == letter);
      case 'Vowels':
        alphabetData =
            vowels.firstWhere((element) => element['letter'] == letter);
      case 'Vokal Oral':
        alphabetData =
            vokalOral.firstWhere((element) => element['letter'] == letter);
      default:
        throw UnimplementedError('No data for category $category');
    }

    // Navigate to the detail page with the alphabet data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlphabetDetailPage(
          letter: alphabetData['letter']!,
          audioUrl: alphabetData['audio']!,
          example1: alphabetData['example1']!,
          ipa1: alphabetData['ipa1']!,
          translation1: alphabetData['translation1']!,
          example2: alphabetData['example2']!,
          ipa2: alphabetData['ipa2']!,
          translation2: alphabetData['translation2']!,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  String getPageTitle() {
    switch (selectedIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Konsonan';
      case 2:
        return 'Semi-konsonan';
      case 3:
        return 'Vokal Oral';
      case 4:
        return 'Vokal Sengau';
      case 5:
        return 'Penyeretan Bunyi'; // New page title for Penyeretan Bunyi
      case 6:
        return 'Kalimat Dasar';
      default:
        return 'French Alphabet Dictionary';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = AlphabetListPage(category: 'Consonants');
        break;
      case 2:
        page = AlphabetListPage(category: 'Semi-Consonants');
        break;
      case 3:
        page = AlphabetListPage(category: 'Vowels');
        break;
      case 4:
        page = AlphabetListPage(category: 'Vokal Oral');
        break;
      case 5:
        page = PenyeretanListPage(); // Show the new Penyeretan Bunyi page
        break;
      case 6:
        page = KalimatDasarListPage();
        break;
      default:
        throw UnimplementedError('No widget for index $selectedIndex');
    }

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
        title: Text(getPageTitle()),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QRScannerPage()),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFF007ae2),
                Color.fromRGBO(0, 194, 226, 1)
              ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
              child: Text(
                'Panduan Pelafalan Niveau A1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.text_fields),
              title: Text('Konsonan'),
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.text_fields),
              title: Text('Semi-Konsonan'),
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.text_fields),
              title: Text('Vokal Oral'),
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.text_fields),
              title: Text('Vokal Sengau'),
              onTap: () {
                setState(() {
                  selectedIndex = 4;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.merge_type),
              title:
                  Text('Penyeretan Bunyi'), // Add Penyeretan Bunyi to the menu
              onTap: () {
                setState(() {
                  selectedIndex =
                      5; // Set the index to 5 to navigate to the new page
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Kalimat Dasar'),
              onTap: () {
                setState(() {
                  selectedIndex =
                      6; // Set the index to 5 to navigate to the new page
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: page,
    );
  }
}

// New Home Page Widget
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bonjour',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Panduan Pelafalan Niveau A1',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class AlphabetListPage extends StatelessWidget {
  final String category;

  AlphabetListPage({required this.category});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> alphabetList;

    switch (category) {
      case 'Consonants':
        alphabetList = consonants;
      case 'Semi-Consonants':
        alphabetList = semiConsonants;
      case 'Vowels':
        alphabetList = vowels;
      case 'Vokal Oral':
        alphabetList = vokalOral;
      default:
        throw UnimplementedError('No list for category $category');
    }

    var appState = context.watch<MyAppState>();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Display 2 cards per row
        crossAxisSpacing: 16, // Space between columns
        mainAxisSpacing: 16, // Space between rows
        childAspectRatio: 1.0, // Make cards square
      ),
      padding: const EdgeInsets.all(16),
      itemCount: alphabetList.length,
      itemBuilder: (context, index) {
        var alphabet = alphabetList[index];
        return GestureDetector(
          onTap: () => appState.navigateToAlphabetPage(
              context, alphabet['letter']!, category),
          child: Card(
            color: const Color.fromARGB(
                255, 0, 122, 227), // Set card color explicitly
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  alphabet['letter']!,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255), // Text color
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AlphabetDetailPage extends StatefulWidget {
  final String letter;
  final String
      audioUrl; // Change this to match the argument in navigateToAlphabetPage
  final String example1;
  final String ipa1;
  final String translation1;
  final String example2;
  final String ipa2;
  final String translation2;

  AlphabetDetailPage({
    required this.letter,
    required this.audioUrl, // Match with 'audioUrl'
    required this.example1,
    required this.ipa1,
    required this.translation1,
    required this.example2,
    required this.ipa2,
    required this.translation2,
  });

  @override
  AlphabetDetailPageState createState() => AlphabetDetailPageState();
}

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

class PenyeretanListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categorizedLiaisons.length,
      itemBuilder: (context, index) {
        String category = categorizedLiaisons.keys.elementAt(index);
        List<Map<String, String>> liaisons = categorizedLiaisons[category]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                category,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
            ),
            // List of liaisons under the category
            ListView.builder(
              shrinkWrap: true, // Ensure it works within the ListView
              physics: NeverScrollableScrollPhysics(), // Avoid nested scrolling
              itemCount: liaisons.length,
              itemBuilder: (context, liaisonIndex) {
                var liaison = liaisons[liaisonIndex];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LiaisonDetailPage(
                        liaison: liaison['liaison']!,
                        category: liaison['category']!,
                        description: liaison['description']!,
                        example: liaison['example']!,
                        pronunciation: liaison['pronunciation']!,
                        translation: liaison['translation']!,
                      ),
                    ),
                  ),
                  child: Card(
                    color: const Color.fromARGB(255, 0, 122, 227),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        liaison['liaison']!,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

// Liaison Detail Page
class LiaisonDetailPage extends StatelessWidget {
  final String liaison;
  final String category;
  final String description;
  final String example;
  final String pronunciation;
  final String translation;

  // Constructor with required parameters
  LiaisonDetailPage({
    required this.liaison,
    required this.category,
    required this.description,
    required this.example,
    required this.pronunciation,
    required this.translation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(liaison),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category: $category',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(description),
            SizedBox(height: 16),
            Text(
              'Example:',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(example),
            SizedBox(height: 16),
            Text(
              'Pronunciation:',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(pronunciation),
            SizedBox(height: 16),
            Text(
              'Translation:',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(translation),
          ],
        ),
      ),
    );
  }
}

class KalimatDasarListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categorizedBasicWords.length,
      itemBuilder: (context, index) {
        String theme = categorizedBasicWords.keys.elementAt(index);
        List<Map<String, String>> words = categorizedBasicWords[theme]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                theme,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
            ),
            // List of words under the theme
            ListView.builder(
              shrinkWrap: true, // Ensure it works within the ListView
              physics: NeverScrollableScrollPhysics(), // Avoid nested scrolling
              itemCount: words.length,
              itemBuilder: (context, wordIndex) {
                var word = words[wordIndex];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WordDetailPage(
                        word: word['word']!,
                        theme: theme,
                        pronunciation: word['pronunciation']!,
                        translation: word['translation']!,
                      ),
                    ),
                  ),
                  child: Card(
                    color: const Color.fromARGB(255, 0, 122, 227),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        word['word']!,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class WordDetailPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(word),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                word,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Tema: $theme',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 16),
            Text(
              'Pengucapan:',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(pronunciation),
            SizedBox(height: 16),
            Text(
              'Terjemahan:',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(translation),
          ],
        ),
      ),
    );
  }
}

class QRScannerPage extends StatefulWidget {
  @override
  QRScannerPageState createState() => QRScannerPageState();
}

class QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan QR Code')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        controller.pauseCamera();
        // Check if the widget is still mounted before using context
        if (mounted) {
          _handleScannedResult(scanData.code!, context);
        }
      }
    });
  }

  void _handleScannedResult(String scannedData, BuildContext context) {
    String category;

    // Determine the category based on the scanned data (e.g., letters or QR content)
    if (RegExp(r'[BCDFGHJKLMNPQRSTVWXYZ]').hasMatch(scannedData)) {
      category = 'Consonants'; // If it's a consonant
    } else if (RegExp(r'[AEIOUY]').hasMatch(scannedData)) {
      category = 'Vowels'; // If it's a vowel
    } else if (RegExp(r'[SemiConsonantPattern]').hasMatch(scannedData)) {
      category = 'Semi-Consonants'; // Define the pattern for semi-consonants
    } else {
      category = 'Vokal Oral'; // You can add more conditions for Vokal Oral
    }

    // Navigate to the alphabet page with the scanned letter and category
    context
        .read<MyAppState>()
        .navigateToAlphabetPage(context, scannedData, category);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
