import 'package:flutter/material.dart';

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
