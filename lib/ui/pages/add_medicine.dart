import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:training_and_diet_app/components/round_icon_button.dart';
import 'package:training_and_diet_app/model/PanelTitle.dart';
import 'package:training_and_diet_app/model/constants.dart';
import 'package:training_and_diet_app/model/dropdown.dart';
import 'package:training_and_diet_app/model/labeledcheckbox.dart';
import 'package:training_and_diet_app/model/medicine_details.dart';
import 'package:training_and_diet_app/ui/pages/medicine.dart';

class AddMedicine extends StatefulWidget {
  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final _formKey = GlobalKey<FormState>();

  //List<dynamic> selectedList = [];
  final newMed = new MedDetails();
  int dosage = 1;
  String selectedValue;
  String Frequency = '';

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
                maxLength: 20,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter medicine name';
                  }
                  return null;
                },
                onChanged: (String value) {
                  newMed.mName = value;
                },
                style: TextStyle(
                  fontSize: 16,
                ),
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.qr_code_scanner_rounded),
                    onPressed: () {
                      print('Search');
                    },
                  ),
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
                            // PanelTitle(
                            //   title: "Dosage",
                            //   isRequired: true,
                            // ),
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
                                SizedBox(
                                  width: 100,
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
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              duration: Duration(seconds: 3),
                              content: Text('Processing Data')),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              duration: Duration(seconds: 2),
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    'A new medicine is successfully added !',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              )),
                        );
                      }
                      //SEND TO DB
                      //newMed.mName = myController.text;
                      newMed.dosage = dosage;
                      newMed.freq = freq;
                      newMed.reminders = reminders;
                      print(newMed.mName);
                      // print(newMed.dosage);
                      // print(newMed.numDays);
                      // print(newMed.dwm);
                      // print(newMed.freq);
                      // print(newMed.reminders);
                      // print("bafhajfbafjafahglkahlkaafkakfalkfakjlf");
                      // print(newMed);

                      if (x == 1)
                        await Future.delayed(const Duration(seconds: 6), () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MedicineReminder(
                                med: newMed.mName,
                              ),
                            ),
                          );
                        });
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
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 10),
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
                      height: 465,
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
