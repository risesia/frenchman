import 'package:flutter/material.dart';

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
              'Pelafalan:',
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
