import 'package:flutter/material.dart';
import 'package:frenchman/pages/alphabet_detail_page_state.dart';

class AlphabetDetailPage extends StatefulWidget {
  final String letter;
  final String
      audioUrl; // Change this to match the argument in navigateToAlphabetPage
  final String example1;
  final String ipa1;
  final String translation1;
  final String example2;
  final String ipa2;
  final String translation2;

  AlphabetDetailPage({
    required this.letter,
    required this.audioUrl, // Match with 'audioUrl'
    required this.example1,
    required this.ipa1,
    required this.translation1,
    required this.example2,
    required this.ipa2,
    required this.translation2,
  });

  @override
  AlphabetDetailPageState createState() => AlphabetDetailPageState();
}
