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
      appBar: AppBar(title: Text('Scan QR Code')),
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
        controller.pauseCamera();
        // Check if the widget is still mounted before using context
        if (mounted) {
          _handleScannedResult(scanData.code!, context);
        }
      }
    });
  }

  void _handleScannedResult(String scannedData, BuildContext context) {
    String category;

    // Determine the category based on the scanned data (e.g., letters or QR content)
    if (RegExp(r'[BCDFGHJKLMNPQRSTVWXYZ]').hasMatch(scannedData)) {
      category = 'Consonants'; // If it's a consonant
    } else if (RegExp(r'[AEIOUY]').hasMatch(scannedData)) {
      category = 'Vowels'; // If it's a vowel
    } else if (RegExp(r'[SemiConsonantPattern]').hasMatch(scannedData)) {
      category = 'Semi-Consonants'; // Define the pattern for semi-consonants
    } else {
      category = 'Vokal Oral'; // You can add more conditions for Vokal Oral
    }

    // Navigate to the alphabet page with the scanned letter and category
    context
        .read<MyAppState>()
        .navigateToAlphabetPage(context, scannedData, category);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
