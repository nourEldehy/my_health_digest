import 'package:flutter/material.dart';
import 'package:training_and_diet_app/model/search_symptoms.dart';

class Symchecker extends StatefulWidget {
  @override
  _SymcheckerState createState() => _SymcheckerState();
}

class _SymcheckerState extends State<Symchecker> {
  List<String> selectedSymptoms = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f0f1),
      appBar: AppBar(
        title: const Text("Symptoms Checker"),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     // onPressed: (){showSearch(context: context,)},
        //   )
        // ],
      ),
      body: Container(
        color: Color(0xFFf5f0f1),
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            OutlinedButton.icon(
                label: Text(
                  "Search for symptoms",
                  style: TextStyle(fontSize: 20),
                ),
                icon: Icon(Icons.search),
                style: OutlinedButton.styleFrom(
                    primary: Colors.blue, side: BorderSide(color: Colors.blue)),
                onPressed: () async {
                  final finalResult = await showSearch(
                      context: context,
                      delegate: SearchSymptoms(
                          allSym: allSym,
                          allSymSugg:
                              allSymSugg)); //OPTIONAL show suggestions that arent already chosen
                  setState(() {
                    if (finalResult != "" &&
                        !selectedSymptoms.contains(finalResult)) {
                      selectedSymptoms.add(finalResult);
                    }
                  });
                }),
            (selectedSymptoms.isEmpty)
                ? Container()
                : Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    //color: Colors.deepOrange,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...selectedSymptoms.map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 2,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              e,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.blue),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  //print(reminders);
                                                  selectedSymptoms.remove(e);
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
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ), //Result here
            Expanded(
              child: ListView.builder(
                  itemCount: allPDFs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(allPDFs[index]),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

final List<String> allPDFs = [
  //load el pdfs here from db
  'pdf1',
  'pdf2',
  'pdf3',
  'pdf4',
  'pdf5',
  'pdf6',
  'pdf7',
];

final List<String> allSym = [
  //load el syms here from db
  'Suggested Symptom 1',
  'Suggested Symptom 2',
  'Suggested Symptom 3',
  'Suggested Symptom 4',
  'Cough',
  'Chest pain',
  'Asthma',
  'Allergies',
  'Common cold',
];

final List<String> allSymSugg = [
  //optional we can add another list of most common symptoms
  //load el syms here from db
  'Suggested Symptom 1',
  'Suggested Symptom 2',
  'Suggested Symptom 3',
  'Suggested Symptom 4',
];
