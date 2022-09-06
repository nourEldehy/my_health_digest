import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';

import 'package:training_and_diet_app/ui/pages/reminders.dart';

Future<String> name;

// Take picture page
class TakePicturePage extends StatefulWidget {
  final CameraDescription camera;

  const TakePicturePage({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePicturePageState createState() => TakePicturePageState();
}


// Take picture page state
class TakePicturePageState extends State<TakePicturePage> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    // Init
    super.initState();
    _controller = CameraController(
      // Camera settings
      widget.camera,
      ResolutionPreset.max,
    );

    // Initialize the controller
    _initializeControllerFuture = _controller.initialize();
  }

  // Dispose of the controller when the widget is disposed
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Food Calories")
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

      floatingActionButton: Container(
        height: 75.0,
        width: 75.0,
        child: FittedBox(
          child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.camera_alt_rounded,
                color: Colors.black,
              ),
              onPressed: () async {
                try {
                  await _initializeControllerFuture;
                  final image = await _controller.takePicture();
                  name = upload(image.path);
                  print("nameeeeeee " + await name);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisplayPicturePage(
                          imagePath: image?.path,
                        ),
                      ),
                    );
                  //   FutureBuilder(future: upload(image.path),
                  //       builder: (context, snapshot) {
                  //         print(" aho ya 7odaaaaa" + jsonDecode(snapshot.data.body));
                  //         if (snapshot.connectionState == ConnectionState.done) {
                  //           if (snapshot.hasData){
                  //             print(" aho ya 7odaaaaa" + jsonDecode(snapshot.data.body));
                  //           }
                  //           return Center(
                  //                   child: Column(
                  //                     children: <Widget>[
                  //                       Text("$image?.path"),
                  //                       Container(
                  //                         width: MediaQuery.of(context).size.width/2,
                  //                         height: MediaQuery.of(context).size.height/2,
                  //                         child: Image.file(File(image?.path)),
                  //                       ),
                  //                       SizedBox(height: 30,),
                  //                       Text("hello",
                  //                         style: TextStyle(
                  //                           fontFamily: "Angel",
                  //                           fontSize: 40,
                  //                           color: Colors.blue,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   )
                  //               ); // Your UI here
                  //         } else if (snapshot.hasError) {
                  //           return Text('Error');
                  //         } else {
                  //           return CircularProgressIndicator();
                  //         }
                  //       }
                  //   );


                print("My Image Path:");
                  print(image?.path);
                }
                catch (error) {
                  print(error);
                }
              }
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


// A new page for displaying the picture
class DisplayPicturePage extends StatelessWidget {
  final String imagePath;
  const DisplayPicturePage({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Display the picture")
        ),
        body: Center(
            child: Column(
              children: <Widget>[
                Text("$imagePath"),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.height/2,
                  child: Image.file(File(imagePath)),
                ),
                SizedBox(height: 30,),
                Text("Apple",
                  style: TextStyle(
                    fontFamily: "Angel",
                    fontSize: 40,
                    color: Colors.blue,
                  ),
                ),
              ],
            )
        )
    );
  }
}

Future<String> upload(String imageFile) async {
  Map<String, dynamic> map;

  var postUri = Uri.parse("http://192.168.191.236/api/imagerecog/upload");

  http.MultipartRequest request = new http.MultipartRequest("POST", postUri);

  http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'pic', imageFile);

  request.files.add(multipartFile);

  http.StreamedResponse response = await request.send();


  print(response.statusCode);
  map =  jsonDecode(await response.stream.bytesToString());
  return map['Name'];
}