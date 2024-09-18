import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(MyApp());
}

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // Alphabet data: letters, pronunciation audio URL, example, and translation
  final consonants = [
    {'letter': 'B', 'audio': 'assets/b.mp3', 'example': 'Bonjour', 'translation': 'Hello'},
    {'letter': 'C', 'audio': 'assets/c.mp3', 'example': 'Chat', 'translation': 'Cat'},
    // Add more consonants here
  ];

  final vowels = [
    {'letter': 'A', 'audio': 'assets/a.mp3', 'example': 'Avion', 'translation': 'Plane'},
    {'letter': 'E', 'audio': 'assets/e.mp3', 'example': 'École', 'translation': 'School'},
    // Add more vowels here
  ];

  void navigateToAlphabetPage(BuildContext context, String letter, bool isConsonant) {
    var alphabetData = isConsonant
        ? consonants.firstWhere((element) => element['letter'] == letter)
        : vowels.firstWhere((element) => element['letter'] == letter);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlphabetDetailPage(
          letter: alphabetData['letter']!,
          audioUrl: alphabetData['audio']!,
          example: alphabetData['example']!,
          translation: alphabetData['translation']!,
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

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = AlphabetListPage(isConsonant: true);  // Consonants
      case 1:
        page = AlphabetListPage(isConsonant: false);  // Vowels
      default:
        throw UnimplementedError('No widget for index $selectedIndex');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('French Alphabet Dictionary'),
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
      body: Row(
        children: [
          NavigationRail(
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.text_fields),
                label: Text('Consonants'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.text_fields),
                label: Text('Vowels'),
              ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),
          Expanded(child: page),
        ],
      ),
    );
  }
}

class AlphabetListPage extends StatelessWidget {
  final bool isConsonant;
  
  AlphabetListPage({required this.isConsonant});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var alphabetList = isConsonant ? appState.consonants : appState.vowels;

    return ListView.builder(
      itemCount: alphabetList.length,
      itemBuilder: (context, index) {
        var alphabet = alphabetList[index];
        return ListTile(
          title: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(alphabet['letter']!,
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
          onTap: () => appState.navigateToAlphabetPage(context, alphabet['letter']!, isConsonant),
        );
      },
    );
  }
}

class AlphabetDetailPage extends StatelessWidget {
  final String letter;
  final String audioUrl;
  final String example;
  final String translation;

  AlphabetDetailPage({
    required this.letter,
    required this.audioUrl,
    required this.example,
    required this.translation,
  });

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();

    return Scaffold(
      appBar: AppBar(title: Text('Details: $letter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pronunciation of $letter',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () async {
                // Use UrlSource if the audio is from a URL, or AssetSource if it's a local asset.
                await player.play(UrlSource(audioUrl)); 
              },
            ),
            SizedBox(height: 20),
            Text('Example: $example'),
            Text('Translation: $translation (in Indonesian)'),
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
    // Assuming the scanned data contains the letter, e.g., "B" for consonants
    bool isConsonant = RegExp(r'[BCDFGHJKLMNPQRSTVWXYZ]').hasMatch(scannedData);
    context.read<MyAppState>().navigateToAlphabetPage(context, scannedData, isConsonant);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
