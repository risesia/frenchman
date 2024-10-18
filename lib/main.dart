import 'package:flutter/material.dart';
import 'package:frenchman/pages/alphabet_detail_page.dart';
import 'package:frenchman/pages/alphabet_list_page.dart';
import 'package:frenchman/pages/home_page.dart';
import 'package:frenchman/pages/kalimat_dasar_list_page.dart';
import 'package:frenchman/pages/penyeretan_list_page.dart';
import 'package:frenchman/pages/qr_scanner_page.dart';
import 'package:provider/provider.dart';

import 'data/alphabet_data.dart';

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

// TODO:
// revisi
// list huruf kapital jadi kecil di list page
// kalimat dasar -> ... jadi kata contoh, ikutin file terbaru
// pake suara rekaman untuk suara yang ga sesuai

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'C\'est facile',
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
          example1: alphabetData['example1'] ?? '',
          ipa1: alphabetData['ipa1'] ?? '',
          translation1: alphabetData['translation1'] ?? '',
          example2: alphabetData['example2'] ?? '',
          ipa2: alphabetData['ipa2'] ?? '',
          translation2: alphabetData['translation2'] ?? '',
          boldLetters: (alphabetData['boldLetters'] ?? '').split(','),
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
        return '';
      case 1:
        return 'Konsonan';
      case 2:
        return 'Semi-konsonan';
      case 3:
        return 'Vokal Oral';
      case 4:
        return 'Vokal Sengau';
      case 5:
        return 'Penyeretan Bunyi';
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
      page = HomePage(
        onNavigate: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      );
      break;
    case 1:
      page = AlphabetListPage(category: 'Consonants');
      break;
    case 2:
      page = AlphabetListPage(category: 'Semi-Consonants');
      break;
    case 3:
      page = AlphabetListPage(category: 'Vokal Oral');
      break;
    case 4:
      page = AlphabetListPage(category: 'Vowels');
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

  return WillPopScope(
    onWillPop: () async {
      if (selectedIndex != 0) {
        // If not on the homepage, go to the homepage
        setState(() {
          selectedIndex = 0;
        });
        return false; // Prevent default back button behavior
      } else {
        return true; // Allow the app to close
      }
    },
    child: Scaffold(
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
          // IconButton(
          //   icon: Icon(Icons.qr_code_scanner),
          //   onPressed: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => QRScannerPage()),
          //   ),
          // ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF007ae2), Color.fromRGBO(0, 194, 226, 1)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "C'est Facile", // App name
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34, // You can adjust the font size
                      fontWeight:
                          FontWeight.bold, // Optional: makes the text bold
                    ),
                  ),
                  Text(
                    'Panduan Pelafalan Niveau A1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Beranda'),
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
              leading: Icon(Icons.text_rotation_none),
              title:
                  Text('Penyeretan Bunyi'), // Add Penyeretan Bunyi to the menu
              onTap: () {
                setState(() {
                  selectedIndex = 5;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.textsms_outlined),
              title: Text('Kalimat Dasar'),
              onTap: () {
                setState(() {
                  selectedIndex = 6;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: page,
    ),
  );
}
}
