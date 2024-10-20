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

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate the number of cards per row based on available width
        int crossAxisCount;
        if (constraints.maxWidth > 1200) {
          crossAxisCount = 6; // 6 cards per row on very wide screens
        } else if (constraints.maxWidth > 800) {
          crossAxisCount = 4; // 4 cards per row on medium-sized screens
        } else {
          crossAxisCount = 2; // 2 cards per row on smaller screens
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
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
                            fontSize: 85,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
