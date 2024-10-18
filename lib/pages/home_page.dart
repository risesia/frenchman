import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import SVG support

class HomePage extends StatelessWidget {
  final void Function(int) onNavigate;

  HomePage({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Makes the Stack cover the entire screen
        children: [
          // Background illustration (duplicated and overlapping SVGs)
          Positioned(
            bottom: -20,
            right: -50,
            child: SvgPicture.asset(
              'assets/E205.svg',
              width: 250,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: 20,
            left: -30,
            child: Transform.rotate(
              angle: -0.5,
              child: SvgPicture.asset(
                'assets/1F968.svg',
                width: 125,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            right: 70,
            child: Transform.rotate(
              angle: -0.4,
              child: SvgPicture.asset(
                'assets/1F490.svg',
                width: 120,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: 30,
            child: Transform.rotate(
              angle: 0.2,
              child: SvgPicture.asset(
                'assets/1F469-200D-1F3A8.svg',
                width: 180,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Add more duplicated illustrations as needed
          Positioned(
            bottom: 40,
            right: 65,
            child: Transform.rotate(
              angle: -0.5,
              child: SvgPicture.asset(
                'assets/1F950.svg',
                width: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            right: -35,
            child: Transform.rotate(
              angle: -1.1,
              child: SvgPicture.asset(
                'assets/1F337.svg',
                width: 125,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Main content in the center
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon/app_icon.png',
                    width: 250,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    'C\'est Facile',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  // SizedBox(height: 0),
                  Text(
                    'Panduan Pelafalan Niveau A1',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: -1.0,
                    alignment: WrapAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          onNavigate(1);
                        },
                        icon: Icon(Icons.text_fields),
                        label: Text('Konsonan'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          onNavigate(2);
                        },
                        icon: Icon(Icons.text_fields),
                        label: Text('Semi-Konsonan'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          onNavigate(3);
                        },
                        icon: Icon(Icons.text_fields),
                        label: Text('Vokal Oral'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          onNavigate(4);
                        },
                        icon: Icon(Icons.text_fields),
                        label: Text('Vokal Sengau'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          onNavigate(5);
                        },
                        icon: Icon(Icons.text_rotation_none),
                        label: Text('Penyeretan Bunyi'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          onNavigate(6);
                        },
                        icon: Icon(Icons.textsms_outlined),
                        label: Text('Kalimat Dasar'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
