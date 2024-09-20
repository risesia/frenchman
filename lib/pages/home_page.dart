import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final void Function(int) onNavigate; // Callback to handle navigation

  HomePage({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centers horizontally
            children: [
              Image.asset(
                'icon/app_icon.png',
                width: 250,
                height: 120,
                fit: BoxFit.contain,
              ),
              Text(
                'C\'est Facilens',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Panduan Pelafalan Niveau A1',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20), // Add space before button
              Wrap(
                spacing: 5.0, // Space between buttons
                runSpacing: 8.0, // Space between rows
                alignment: WrapAlignment.center, // Center the buttons
                children: [
                  TextButton.icon(
                    onPressed: () {
                      onNavigate(1);
                    },
                    icon: Icon(Icons.text_fields),
                    label: Text('Konsonan'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Colors.redAccent, // Button background color
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0), // Button padding
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
                      backgroundColor:
                          Colors.redAccent, // Button background color
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0), // Button padding
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
                      backgroundColor:
                          Colors.redAccent, // Button background color
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0), // Button padding
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
                      backgroundColor:
                          Colors.redAccent, // Button background color
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0), // Button padding
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      onNavigate(5);
                    },
                    icon: Icon(Icons.text_rotation_none),
                    label: Text('Penyeretean Bunyi'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Colors.redAccent, // Button background color
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0), // Button padding
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
                      backgroundColor:
                          Colors.redAccent, // Button background color
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0), // Button padding
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
