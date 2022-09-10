import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:training_and_diet_app/model/search_symptoms.dart';

var map;
var savedtoken;

class Symchecker extends StatefulWidget {
  @override
  _SymcheckerState createState() => _SymcheckerState();
}

class _SymcheckerState extends State<Symchecker> {
  List<String> selectedSymptoms = [];
  TextEditingController controller;

  @override
  void initState() {
    getallsymptoms();
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
                  getdiseases(selectedSymptoms);
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
                                                  getdiseases(selectedSymptoms);
                                                  print(allPDFs);
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
         Expanded(
           child: ListView.builder(
    itemCount: allPDFs.length,
        itemBuilder: (context, index) => Card(
          shadowColor: Colors.grey ,
          color: Colors.blue[100 * (index % 9)],
          elevation: 4,
          margin: EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
          child: new Column(
            children: <Widget>[
              new Padding(
                  padding: new EdgeInsets.all(10.0),
                  child: new Padding(
                    padding: new EdgeInsets.all(7.0),
                    child: new Text(allPDFs[index],style: new TextStyle(fontSize: 18.0)),
                  )
              )
            ],
          ),
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

  List<String> allPDFs = [
    //TODO: load el pdfs here from db
  ];
  List<String> allSym = [
    //TODO: load el syms here from db
  ];

  Future<void> getallsymptoms() async {
    allSym = [];

    final response = await http.get(
      "http://10.0.2.2/api/sym-checker/symptoms",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    map = json.decode(response.body) as List;
    for(int i = 0; i < map.length; i++)
    {
      allSym.add(json.decode(response.body)[i]);
    }
    print(allSym);
  }

  Future<void> getdiseases(x) async {
    allPDFs = [];
    Map<String, dynamic> data = {
      "symptoms": x,
    };

    final response = await http.post(
      "http://10.0.2.2/api/sym-checker/find-disease",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    map = json.decode(response.body) as List;
    for(int i = 0; i < map.length; i++)
    {
      allPDFs.add(json.decode(response.body)[i]);
    }
    print(allPDFs);
    setState(() {
      allPDFs;
    });
  }
}