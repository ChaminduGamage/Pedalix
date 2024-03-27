import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedalix_app/components/navbar.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  String _scanResult = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //Scan function
  Future<void> scanQRCode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to Scan';
    }
    if (!mounted) return;
    setState(() {
      _scanResult = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF127368)),
          leading: Container(
            margin: EdgeInsets.only(left: 16, top: 12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
          ),
        ),
        drawer: Drawer(
          child: navbar(), // Assuming navbar() returns a Drawer widget
        ),
        backgroundColor: const Color(0xFF127368),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 600,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      'Scan QR Code ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Scan the QR code to unlock your bike \nand embark on your eco'
                      '-friendly adventure. ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                    GestureDetector(
                      onTap: scanQRCode,
                      child: Image.asset(
                        'assets/qr_code.png',
                        height: 150,
                        width: 150,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Tap to Scan...',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFF6F6F6),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    child: Text(
                      'Cancel Scan',
                      style: TextStyle(
                        color: Color(0xFF127368),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
