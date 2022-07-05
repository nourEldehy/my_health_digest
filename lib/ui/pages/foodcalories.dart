import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';

import 'package:training_and_diet_app/ui/pages/New/reminders.dart';


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
          title: Text("Take a picture demo")
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
                  // String name = upload(File(image.path)).toString();
                  // print("nameeeeeee" + name);
                  // String name = upload(File(image.path)) as String;
                  // If the picture was taken
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => DisplayPicturePage(
                  //         imagePath: image?.path,
                  //       ),
                  //     ),
                  //   );
                    FutureBuilder(future: upload(File(image.path)),
                        builder: (context, snapshot) {
                          print(" aho ya 7odaaaaa" + jsonDecode(snapshot.data.body));
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasData){
                              print(" aho ya 7odaaaaa" + jsonDecode(snapshot.data.body));
                            }
                            return Center(
                                    child: Column(
                                      children: <Widget>[
                                        Text("$image?.path"),
                                        Container(
                                          width: MediaQuery.of(context).size.width/2,
                                          height: MediaQuery.of(context).size.height/2,
                                          child: Image.file(File(image?.path)),
                                        ),
                                        SizedBox(height: 30,),
                                        Text("hello",
                                          style: TextStyle(
                                            fontFamily: "Angel",
                                            fontSize: 40,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    )
                                ); // Your UI here
                          } else if (snapshot.hasError) {
                            return Text('Error');
                          } else {
                            return CircularProgressIndicator();
                          }
                        }
                    );


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
                Text("hello",
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

upload(File imageFile) async {
  Map<String, dynamic> map;
  // open a bytestream
  var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  // get file length
  var length = await imageFile.length();

  // string to uri
  var uri = Uri.parse("http://10.0.2.2/api/imagerecog/upload");

  // create multipart request
  var request = new http.MultipartRequest("POST", uri);

  // multipart that takes file
  var multipartFile = new http.MultipartFile('pic', stream, length,
      filename: basename(imageFile.path));

  // add file to multipart
  request.files.add(multipartFile);

  // send
  var response = await request.send();
  print(response.statusCode);


  // listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    print(jsonDecode(value));
    map = json.decode(value);
    print(map['Name']);
  }
  );
  // return map['Name'];
}