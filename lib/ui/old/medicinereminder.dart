import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:training_and_diet_app/ui/pages/add_medicine.dart';

import '../add_medicine.dart';
import 'medicines.dart';

var englishName = " ";

class Medicine extends StatefulWidget {
  @override
  _MedicineState createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      http.Response response = await getmedicinename(barcodeScanRes);
      Map<String, dynamic> map = json.decode(response.body)[0];
      englishName = map['enName'];
      print("Scanned Barcode: ");
      print(barcodeScanRes);
      print("Received Medicine Name: " + map['enName']);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Medicine Reminder')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Barcode Scanning
              Custom3DCard(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    scanBarcodeNormal();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddMedicine(),
                      ),
                    );
                  },
                  child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/Barcode-3.png')),
                ),
              ),
              Text(
                "Scan Barcode",
                style: const TextStyle(
                  fontSize: 20,
                  // color: Colors.black12,
                ),
              ),
              Text(
                englishName,
                style: const TextStyle(
                  fontSize: 20,
                  // color: Colors.black12,
                ),
              ),
              SizedBox(
                height: 30,
              ),

              //Enter Manually
              Custom3DCard(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () async {
                    // debugPrint('Card tapped.');
                    http.Response response =
                        await getmedicinename("6223003973681");
                    Map<String, dynamic> map = json.decode(response.body)[0];
                    print("English Name: " + map['enName']);
                    print("Whole Body: ");
                    print(json.decode(response.body)[0]);
                  },
                  child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/Manually.png')),
                ),
              ),
              Text(
                "Enter Manually",
                style: const TextStyle(
                  fontSize: 18,
                  // color: Colors.black12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<http.Response> getmedicinename(String barcode) {
  return http.post(
    Uri.parse('http://192.168.43.113/api/barcode/check'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"barcode": barcode}),
  );
}
