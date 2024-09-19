import 'package:flutter/material.dart';
import 'package:frenchman/data/basic_word_data.dart';
import 'package:frenchman/pages/word_detail_page.dart';

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
