import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

List title=[];
List link=[];
int flag = 0;
//Creating a class user to store the data;

class Myhealth extends StatefulWidget {
  @override
  _MyhealthState createState() => _MyhealthState();
}

class _MyhealthState extends State<Myhealth> {
//Applying get request.
  @override
  Widget build(BuildContext context) {
    (flag == 0) ?

    getRequest()

        : null;

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            // Add the app bar to the CustomScrollView.
            SliverAppBar(
              snap: true,
              floating: true,
              backgroundColor: Colors.transparent,
              expandedHeight: 300,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/health.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return CustomCard(title: title[index], link: link[index], index: index);
                },
                childCount: title.length,
              ),
            ),
            // SliverGrid(
            //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //     maxCrossAxisExtent: 200.0,
            //     mainAxisSpacing: 10.0,
            //     crossAxisSpacing: 10.0,
            //     childAspectRatio: 2.5,
            //   ),
            //   delegate: SliverChildBuilderDelegate(
            //         (BuildContext context, int index) {
            //       return CustomCard(tittle: title[index], linnk: link[index], index: index);
            //     },
            //     childCount: title.length,
            //   ),
            // ),
          ],
        )
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String link;
  final int index;

  const CustomCard({this.title, this.link, this.index});
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
          builder: (_) => PDFViewerFromUrl(
            url: link,
            name: title,
          ),
        ),
      ),
      child: Card(
        shadowColor: Colors.grey ,
        color: Colors.grey[100 * (index % 9)],
        elevation: 8,
        margin: EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
        child: new Column(
          children: <Widget>[
            new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Padding(
                  padding: new EdgeInsets.all(7.0),
                  child: new Text(title,style: new TextStyle(fontSize: 18.0)),
                )
            )
          ],
        ),
      ),
    );
  }
}

class PDFViewerFromUrl extends StatelessWidget {
  const PDFViewerFromUrl({Key key, this.url, this.name}) : super(key: key);

  final String url;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Color.fromRGBO(125,129,134,1),
      ),
      body: const PDF().fromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}

getRequest() async {
  //replace your restFull API here.
  String url = "http://10.0.2.2/api/pdfs/get-pdfs/en/my-health";
  final response = await http.get(url);

  var responseData = json.decode(response.body);
  var response2 = responseData.toString().split(",");
  for (var i = 0; i < response2.length; i++) {

    var temp =  response2[i].split(": ");
    title.add(temp[0].replaceAll("{", ""));
    link.add(temp[1].replaceAll("}", ""));
  }
  flag=1;
}