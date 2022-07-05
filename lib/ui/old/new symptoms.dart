import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';



class Symptoms extends StatefulWidget {
  @override
  _MyAppState createState() =>
      new _MyAppState();
}

class _MyAppState extends State<Symptoms>
{
   List<String> imageList = [
    "assets/Front Side.png",
     "assets/Back Side.png",
   ];

   String _operation = "No Gesture";
  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = new CarouselController();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading:
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          title: Text(" Symptoms Checker ") ,
          ),
        body:
          Center(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 500,
                  viewportFraction: 1.2,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: true,
                  autoPlay: false,
                ),
                carouselController: carouselController,
                items: imageList.map((e) => Stack(
                  children: <Widget>[
                Center(
                  child: InteractiveViewer(
                        child: Stack(
                          children:[
                            Image.asset(e, fit: BoxFit.fill,),

                          (e == "assets/Front Side.png") ?
                          // Front View
                          Stack(
                            children: <Widget>[
                              //Head
                              drawTouchableArea(69, 228, 34, 43, "Head", 0, 1),

                              //Chest
                              drawTouchableArea(133, 214, 63, 34, "Chest", 0, 1),

                              //Abdomen - Stomach
                              drawTouchableArea(169, 217, 55, 55, "Abdomen", 0, 1),

                              //Pelvis
                              drawTouchableArea(226, 228, 38, 27, "Pelvis", 0, 1),

                              //Left Shoulder
                              drawTouchableArea(140, 271, 23, 12, "Shoulders", 70, 1),

                              //Left Arm
                              drawTouchableArea(165, 281, 27, 80, "Arms", 0, 1),

                              //Right Shoulder
                              drawTouchableArea(133, 191, 28, 21, "Shoulders", 120, 1),

                              //Right Arm
                              drawTouchableArea(157, 177, 27, 82, "Arms", 0, 1),

                              //Left Leg
                              drawTouchableArea(253, 251, 28, 140, "Legs", 0, 1),

                              //Right Leg
                              drawTouchableArea(250, 198, 30, 150, "Legs", 10, 1),

                              //Left Foot
                              drawTouchableArea(392, 259, 45, 22, "Foot", 18, 1),

                              //Right Foot
                              drawTouchableArea(405, 176, 39, 23, "Foot", 107, 1),
                            ],
                          )

                              : (e == "assets/Back Side.png") ?
                          // Back View
                          Stack(
                            children: <Widget>[

                              //Head
                              drawTouchableArea(69, 223, 34, 40, "Head", 0, 2),

                              //Chest
                              drawTouchableArea(125, 204, 66, 43, "Back", 0, 2),

                              //Abdomen - Stomach
                              drawTouchableArea(171, 211, 55, 38, "Lower Back", 0, 2),

                              //Buttock
                              drawTouchableArea(210, 208, 60, 45, "Buttock", 0, 2),

                              //Right Shoulder
                              drawTouchableArea(125, 267, 23, 21, "Shoulders", 60, 2),

                              //Right Arm
                              drawTouchableArea(158, 283, 22, 80, "Arms", 165, 2),

                              //Left Shoulder
                              drawTouchableArea(135, 185, 21, 19, "Shoulders", 130, 2),

                              //Left Arm
                              drawTouchableArea(160, 178, 24, 82, "Arms", 0, 2),

                              //Right Leg
                              drawTouchableArea(255, 245, 35, 155, "Legs", 175, 2),

                              //Left Leg
                              drawTouchableArea(255, 191, 33, 138, "Legs", 10, 2),

                              //Right Foot
                              drawTouchableArea(410, 254, 48, 22, "Foot", 166, 2),

                              //Left Foot
                              drawTouchableArea(400, 173, 39, 23, "Foot", 107, 2),
                            ],
                          )
                              :  Center()
                        ],),
                  ),
                ),

                    Positioned(
                      top: 15,
                      left: 400,
                      child: IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.exit_to_app),
                        tooltip: 'Back',
                        color: Colors.grey,
                        onPressed: () {
                          update("No Gesture");
                        },
                      ),
                    ),
                  ],
                )).toList(),
              ),
              SizedBox(height: 30),
              Text(
                _operation,
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
        ),
      );
    }

   void updateText(String text, double a) {
     (a == 1) ?
     imageList = ['assets/Front/$text.png']
     :
     imageList = ['assets/Back/$text.png'];
     setState(() {
       _operation = text;
     });
   }

   void update(String text) {
     imageList = [
       'assets/Front Side.png',
       'assets/Back Side.png',
     ];
     setState(() {
       _operation = text;
     });
   }

    drawTouchableArea(double t,double l, double w,double h, String part, double a, double b) {
     return Positioned(
       top: t,
       left: l,
       child: GestureDetector(
         child: RotationTransition(
           turns: new AlwaysStoppedAnimation(a / 360),
           child: Container(
             decoration: BoxDecoration(
               color: Colors.transparent,
               border: Border.all(color: Colors.transparent,),
               borderRadius: BorderRadius.all(Radius.circular(20)),
             ),
             width: w,
             height: h,
           ),
         ),
         onTap: () => updateText(part,b),
       ),
     );
   }
}