import 'package:flutter/material.dart';
import 'package:training_and_diet_app/model/search_symptoms.dart';

class Symchecker extends StatefulWidget {
  @override
  _SymcheckerState createState() => _SymcheckerState();
}

class _SymcheckerState extends State<Symchecker> {
  List<String> selectedSymptoms = [];
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
  }

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
            Autocomplete<String>(
              fieldViewBuilder:
                  (context, controller, focusNode, onEditingComplete) {
                this.controller = controller;

                return TextField(
                  controller: controller,
                  style: TextStyle(fontSize: 20),
                  focusNode: focusNode,
                  onEditingComplete: onEditingComplete,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]),
                    ),
                    hintText: "What do you feel?",
                    hintStyle: TextStyle(
                        color: Colors.blue.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                  ),
                );
              },
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return allSym.where((String option) {
                  return option.contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                setState(() {
                  if (!selectedSymptoms.contains(selection))
                    selectedSymptoms.add(selection);
                  //TODO: Eb3t li 7oda el list el esmha selectedSymptoms
                  //TODO: Hat receive pdf files 7otha fi el list el esmha allPDFs
                  //TODO: Make sure en enta t3ml keda gowa el setState deh
                  controller.clear();
                });
                print('Selected Symptoms $selectedSymptoms');
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),

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
                                                  selectedSymptoms.remove(e);
                                                  //TODO: SEND SelectedSymptoms li 7oda and receive the pdfs
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
                  ),
            //TODO: Shof hatshow el pdfs ezy, enta 2olt zay myhealth
            //Result here
            // Expanded(
            //   child: ((selectedSymptoms.contains("Cough") &&
            //           selectedSymptoms.contains("Fever") &&
            //           selectedSymptoms.contains("Loss of taste or smell")))
            //       ? ListView.builder(
            //           itemCount: 1,
            //           itemBuilder: (context, index) {
            //             return Column(
            //               children: [
            //                 ListTile(
            //                   title: Text(allPDFs[2]),
            //                 ),
            //               ],
            //             );
            //           })
            //       : (selectedSymptoms.contains("Cough") &&
            //               selectedSymptoms.contains("Fever"))
            //           ? ListView.builder(
            //               itemCount: 1,
            //               itemBuilder: (context, index) {
            //                 return Column(
            //                   children: [
            //                     ListTile(
            //                       title: Text(allPDFs[2]),
            //                     ),
            //                     Divider(),
            //                     ListTile(
            //                       title: Text(allPDFs[4]),
            //                     ),
            //                     Divider(),
            //                     ListTile(
            //                       title: Text(allPDFs[7]),
            //                     ),
            //                   ],
            //                 );
            //               })
            //           : (selectedSymptoms.contains("Cough"))
            //               ? ListView.builder(
            //                   itemCount: 1,
            //                   itemBuilder: (context, index) {
            //                     return Column(
            //                       children: [
            //                         ListTile(
            //                           title: Text(allPDFs[2]),
            //                         ),
            //                         Divider(),
            //                         ListTile(
            //                           title: Text(allPDFs[4]),
            //                         ),
            //                         Divider(),
            //                         ListTile(
            //                           title: Text(allPDFs[7]),
            //                         ),
            //                         Divider(),
            //                         ListTile(
            //                           title: Text(allPDFs[13]),
            //                         ),
            //                         Divider(),
            //                         ListTile(
            //                           title: Text(allPDFs[15]),
            //                         ),
            //                         Divider(),
            //                         ListTile(
            //                           title: Text(allPDFs[16]),
            //                         ),
            //                         Divider(),
            //                       ],
            //                     );
            //                   })
            //               : ListView.builder(
            //                   itemCount: allPDFs.length,
            //                   itemBuilder: (context, index) {
            //                     return Column(
            //                       children: [
            //                         ListTile(
            //                           title: Text(allPDFs[index]),
            //                         ),
            //                         Divider(),
            //                       ],
            //                     );
            //                   }),
            // ),
          ],
        ),
      ),
    );
  }
}

final List<String> allPDFs = [
  //TODO: load el pdfs here from db
  // 'Bipolar Disorder',
  // 'Cavities',
  // 'Covid 19',
  // 'Coronary Heart disease',
  // 'Influenza',
  // 'Dislocation',
  // 'Gum Infection',
  // 'Cold flu',
  // 'Genetic Disorder',
  // 'Food Poisoning',
  // 'Esophageal Cancer',
  // 'Ear Infection',
  // 'Cystic Fibrosis',
  // 'Heart Attack',
  // 'Hypertension',
  // 'Mouth Cancer',
  // 'Liver Cancer',
];

final List<String> allSym = [
  //TODO: load el syms here from db
  'Cough',
  'Congested or runny nose',
  'Ear or hearing problems',
  'Eye or vision problems',
  'Upset stomach or indigestion',
  'Numbness or tingling sensations',
  'Drowsiness',
  'Memory problems',
  'Difficulty concentrating',
  'Muscle weakness',
  'Loss of taste or smell',
  'Fever',
  'Chest pain',
  'Asthma',
  'Allergies',
  'Common cold',
];
