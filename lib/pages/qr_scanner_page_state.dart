import 'package:flutter/material.dart';
import 'package:frenchman/main.dart';
import 'package:frenchman/pages/qr_scanner_page.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pindai QR')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        controller.pauseCamera(); // Pause the camera for processing
        // Check if the widget is still mounted before using context
        if (mounted) {
          _handleScannedResult(scanData.code!, context);
        }
      }
    });
  }

 void _handleScannedResult(String scannedData, BuildContext context) {
  String category;

  // Check for multiple characters in the scanned data
  if (RegExp(r'^[bdfgkʃlmnpʁstvzʒŋɲ]+$').hasMatch(scannedData)) {
    category = 'Consonants'; // If it's a consonant
  } else if (RegExp(r'^[ɑ̃ɛ̃ɔ̃œ̃]+$').hasMatch(scannedData)) {
    category = 'Vowels'; // If it's a vowel
  } else if (RegExp(r'^[jwɥ]+$').hasMatch(scannedData)) {
    category = 'Semi-Consonants'; // Define the pattern for semi-consonants
  } else if (RegExp(r'^[aɑeɛioɔuyøœə]+$').hasMatch(scannedData)) {
    category = 'Vokal Oral'; // Define the pattern for semi-consonants
  } else {
    // Handle unmatched data
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tidak ditemukan: $scannedData')),
    );
    // Resume the camera for further scanning
    controller?.resumeCamera(); // Resume the camera to scan again
    return; // Early return to prevent navigation
  }

  // Navigate to the alphabet page with the scanned word and category
  context
      .read<MyAppState>()
      .navigateToAlphabetPage(context, scannedData, category);

  // Resume the camera for the next scan
  controller?.resumeCamera(); // Resume the camera after processing
}
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
