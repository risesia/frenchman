import 'package:flutter/material.dart';
import 'package:frenchman/data/liaisons_data.dart';
import 'package:frenchman/pages/liaison_detail_page.dart';

class PenyeretanListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categorizedLiaisons.length,
      itemBuilder: (context, index) {
        String category = categorizedLiaisons.keys.elementAt(index);
        List<Map<String, dynamic>> liaisons =
            categorizedLiaisons[category]!; // Updated to accept dynamic Map

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
                          suara: liaison['suara']!,
                          description: liaison['description']!,
                          examples: List<Map<String, String>>.from(liaison[
                              'examples']), // Ensure 'examples' is a List<Map<String, String>>
                        ),
                      )),
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
                                  fontWeight: FontWeight.normal,
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
