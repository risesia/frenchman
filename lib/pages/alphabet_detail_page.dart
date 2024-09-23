import 'package:flutter/material.dart';
import 'package:frenchman/pages/alphabet_detail_page_state.dart';

class AlphabetDetailPage extends StatefulWidget {
  final String letter;
  final String audioUrl;
  final String example1;
  final String ipa1;
  final String translation1;
  final String example2;
  final String ipa2;
  final String translation2;
  final List<String> boldLetters; // Change to List<String>

  AlphabetDetailPage({
    required this.letter,
    required this.audioUrl,
    required this.example1,
    required this.ipa1,
    required this.translation1,
    required this.example2,
    required this.ipa2,
    required this.translation2,
    required this.boldLetters, // Initialize boldLetters
  });

  @override
  AlphabetDetailPageState createState() => AlphabetDetailPageState();
}
