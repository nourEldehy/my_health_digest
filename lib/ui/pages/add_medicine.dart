import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:training_and_diet_app/model/PanelTitle.dart';
import 'package:training_and_diet_app/model/dropdown.dart';
import 'package:training_and_diet_app/model/labeledcheckbox.dart';
import 'package:training_and_diet_app/model/medicine_details.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:training_and_diet_app/ui/pages/medicine_reminder.dart';
import 'package:training_and_diet_app/ui/New folder/medicines.dart';

var englishName = " ";

class AddMedicine extends StatefulWidget {
  TextEditingController b;

  @override
  _AddMedicineState createState() => _AddMedicineState();
}

@override
class _AddMedicineState extends State<AddMedicine> {
  final _formKey = GlobalKey<FormState>();

  var b = TextEditingController();
  final newMed = new MedDetails();
  int dosage = 1;
  var savedtoken = "";
  String selectedValue;
  String Frequency = '';
  String _scanBarcode = 'Unknown';

  List<String> freq = [];
  List<String> reminders = [];
  final allChecked = LabeledCheckbox(label: 'Everyday');
  final checkBoxList = [
    LabeledCheckbox(label: 'Sunday', abv: 'Sun'),
    LabeledCheckbox(label: 'Monday', abv: 'Mon'),
    LabeledCheckbox(label: 'Tuesday', abv: 'Tues'),
    LabeledCheckbox(label: 'Wednesday', abv: 'Wed'),
    LabeledCheckbox(label: 'Thursday', abv: 'Thurs'),
    LabeledCheckbox(label: 'Friday', abv: 'Fri'),
    LabeledCheckbox(label: 'Saturday', abv: 'Sat'),
  ];

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      http.Response response = await getmedicinename(barcodeScanRes, token);
      Map<String, dynamic> map = json.decode(response.body)[0];
      setState(() {
        englishName = map['enName'];
        b.text = englishName;
        newMed.mName = englishName;
      });
      print("Scanned Barcode: ");
      print(barcodeScanRes);
      print("Received Medicine Name: " + map['enName']);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    } on RangeError {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unsuccessful')),
      );
      print("Unsuccessful");
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.lightBlue,
          ),
          centerTitle: true,
          title: Text(
            "Add New Reminder",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          elevation: 0.0,
        ),
        body: Container(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            children: <Widget>[
              Image(
                image: AssetImage('assets/medicine.png'),
                fit: BoxFit.cover,
              ),
              PanelTitle(
                title: "Medicine Name",
                isRequired: true,
              ),
              TextFormField(
                controller: b,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter medicine name';
                  }
                  return null;
                },
                onChanged: (String value) {
                  newMed.mName = value;
                },
                // newMed.mName = value;
                style: TextStyle(
                  fontSize: 16,
                ),
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: ("Enter Medicine Name"),
                  hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                    child: Divider(
                  height: 10,
                  thickness: 2,
                  indent: 65,
                  endIndent: 5,
                  color: Colors.grey,
                )),
                Text("OR", style: TextStyle(fontSize: 18, color: Colors.grey)),
                Expanded(
                    child: Divider(
                  height: 10,
                  thickness: 2,
                  indent: 5,
                  endIndent: 60,
                  color: Colors.grey,
                )),
              ]),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    scanBarcodeNormal();
                  });
                },
                label: Text("Scan Barcode"),
                icon: const Icon(Icons.document_scanner),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    PanelTitle(
                      title: "Dosage",
                      isRequired: true,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RawMaterialButton(
                              elevation: 0.0,
                              child: FaIcon(
                                FontAwesomeIcons.minus,
                                color: Colors.lightBlue,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (dosage != 1) {
                                    dosage--;
                                  }
                                });
                              },
                              constraints: BoxConstraints.tightFor(
                                width: 35.0,
                                height: 35.0,
                              ),
                              shape: CircleBorder(),
                              fillColor: Color(0xFFf0ebf1),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              dosage.toString() +
                                  (dosage > 1 ? " Tablets" : " Tablet"),
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            RawMaterialButton(
                              elevation: 0.0,
                              child: FaIcon(FontAwesomeIcons.plus,
                                  color: Colors.lightBlue),
                              onPressed: () {
                                setState(() {
                                  if (dosage < 4) dosage++;
                                });
                              },
                              constraints: BoxConstraints.tightFor(
                                width: 35.0,
                                height: 35.0,
                              ),
                              shape: CircleBorder(),
                              fillColor: Color(0xFFf0ebf1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            PanelTitle(
                              title: "Duration",
                              isRequired: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            PanelTitle(
                              title: "Frequency",
                              isRequired: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: TextFormField(
                                    maxLength: 2,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    onChanged: (String value) {
                                      //print(value);
                                      newMed.numDays = int.parse(value);
                                    },
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    decoration: InputDecoration(
                                      counterText: "",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: SizedBox(
                                    width: 110,
                                    child: DropdownButtonFormField(
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          filled: true,
                                        ),
                                        //dropdownColor: Colors.blueAccent,
                                        value: selectedValue,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '';
                                          }
                                          return null;
                                        },
                                        onChanged: (String newValue) {
                                          setState(() {
                                            selectedValue = newValue;
                                            newMed.dwm = selectedValue;
                                          });
                                        },
                                        items: dropdownItems),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _dropdown(context);
                          });
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text(
                              (Frequency == '') ? "Please choose" : Frequency,
                              style: (Frequency == '')
                                  ? TextStyle(fontSize: 18, color: Colors.grey)
                                  : TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: PanelTitle(
                  title: "Reminders",
                  isRequired: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Column(
                  children: [
                    ...reminders.map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: SizedBox(
                                    width: 150,
                                    height: 30,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                //print(reminders);
                                                reminders.remove(e);
                                                //print(reminders);
                                              });
                                            },
                                            //color: Colors.green,
                                            child: SizedBox(
                                              width: 50,
                                              height: 30,
                                              child: Center(
                                                child: const Text(
                                                  'X',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _show();
                    },
                    child: const Text(
                      'Add Time',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      int x = 1;
                      if (freq.isEmpty) {
                        x = 0;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please choose frequency')),
                        );
                      }
                      if (reminders.isEmpty) {
                        x = 0;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please set at least 1 reminder')),
                        );
                      }
                      if (_formKey.currentState.validate() && x == 1) {
                        //SEND TO DB
                        newMed.dosage = dosage;
                        newMed.freq = freq;
                        newMed.reminders = reminders;
                        print(newMed.mName);
                        final storage = FlutterSecureStorage();
                        final token = await storage.read(key: "token");
                        http.Response received = await remindersaver(
                            newMed.mName,
                            newMed.dosage,
                            newMed.numDays,
                            newMed.dwm,
                            newMed.freq,
                            newMed.reminders,
                            token);

                        await Future.delayed(const Duration(seconds: 0), () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MedicineReminder(),
                            ),
                          );
                        });
                      }
                    },
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _show() async {
    final TimeOfDay newReminder =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (newReminder != null) {
      setState(() {
        if (reminders.length < 4 &&
            !reminders.contains(formatTimeOfDay(newReminder))) {
          reminders.add(formatTimeOfDay(newReminder));
        }
        // print(reminders);
        //print("HI" + formatTimeOfDay(newReminder));
      });
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  onAllClicked(LabeledCheckbox ckbItem) {
    final newValue = !ckbItem.value;
    setState(() {
      ckbItem.value = newValue;
      checkBoxList.forEach((element) {
        element.value = newValue;
      });
    });
  }

  onItemClicked(LabeledCheckbox ckbItem) {
    final newValue = !ckbItem.value;
    setState(() {
      ckbItem.value = newValue;

      if (!newValue) {
        allChecked.value = false;
      } else {
        final allListChecked = checkBoxList.every((element) => element.value);
        allChecked.value = allListChecked;
      }
    });
  }

  printing() {
    int i = 0;
    freq = [];
    checkBoxList.forEach((element) {
      if (allChecked.value == true) {
        //print(allChecked.label);
        setState(() {
          Frequency = allChecked.label;
          freq.add(element.label);
        });
      } else if (element.value == true) {
        setState(() {
          freq.add(element.abv);
          Frequency = freq.join(", ");
          // print(freq);
        });
      } else if (element.value == false) {
        i++;
      }
    });
    if (i > 6) {
      setState(() {
        Frequency = "";
        //print(Frequency);
      });
    }
    // print(i);
  }

  void _dropdown(context) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setstate) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                allChecked.value = false;
                                checkBoxList.forEach((element) {
                                  element.value = false;
                                });
                                setState(() {
                                  Frequency = "";
                                });
                              },
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Center(
                                  child: const Text(
                                    'X',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Frequency",
                            style: TextStyle(fontSize: 25),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                printing();
                              },
                              child: SizedBox(
                                width: 70,
                                height: 50,
                                child: Center(
                                  child: const Text(
                                    'Done',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      height: 425,
                      child: ListView(
                        children: [
                          ListTile(
                            onTap: () {
                              setstate(() {
                                onAllClicked(allChecked);
                              });
                            },
                            trailing: Checkbox(
                              value: allChecked.value,
                              onChanged: (value) {
                                setstate(() {
                                  onAllClicked(allChecked);
                                });
                              },
                            ),
                            title: Text(
                              allChecked.label,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(),
                          ...checkBoxList
                              .map((item) => ListTile(
                            onTap: () {
                              setstate(() {
                                onItemClicked(item);
                              });
                            },
                            trailing: Checkbox(
                              value: item.value,
                              onChanged: (value) {
                                setstate(() {
                                  onItemClicked(item);
                                });
                              },
                            ),
                            title: Text(
                              item.label,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                              .toList()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Future<http.Response> getmedicinename(String barcode, String token) {
  return http.post(
    Uri.parse('http://192.168.43.113/api/barcode/check'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
    body: jsonEncode(<String, String>{"barcode": barcode}),
  );
}

Future<http.Response> remindersaver(String enName, int dosage, int duration,
    String durationunit, List frequency, List time, String token) {
  Map<String, dynamic> data = {
    "name": enName,
    "dosage": dosage,
    "duration": {"value": duration, "unit": durationunit},
    "frequency": frequency,
    "time": time
  };
  return http.post(
    Uri.parse('http://10.0.2.2/api/med-reminder/add'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
    body: jsonEncode(data),
  );
}
