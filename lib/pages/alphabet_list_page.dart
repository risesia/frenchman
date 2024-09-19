import 'package:flutter/material.dart';
import 'package:frenchman/data/alphabet_data.dart';
import 'package:frenchman/main.dart';
import 'package:provider/provider.dart';

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
