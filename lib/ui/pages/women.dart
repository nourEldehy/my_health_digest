import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

var title = [];
var link = [];
//Creating a class user to store the data;

class Women extends StatefulWidget {
  @override
  _WomenState createState() => _WomenState();
}

class _WomenState extends State<Women> {
//Applying get request.

  Future<List<User>> getRequest() async {
    //replace your restFull API here.
    String url = "http://10.0.2.2/api/pdfs/get-pdfs/women";
    final response = await http.get(url);

    var responseData = json.decode(response.body);
    var response2 = responseData.toString().split(",");
    for (var i = 0; i < response2.length; i++) {
      var temp = response2[i].split(": ");
      title.add(temp[0].replaceAll("{", ""));
      link.add(temp[1].replaceAll("}", ""));
    }
  }

  @override
  Widget build(BuildContext context) {
    getRequest();
    List<Widget> cards = new List.generate(
            title.length, (i) => new CustomCard(title: title[i], link: link[i]))
        .toList();
    title = [];
    link = [];
    return new Scaffold(
        // appBar: new AppBar(
        //   title: new Text('My First App'),
        //   backgroundColor:Colors.lightBlue,
        // ),
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          snap: true,
          floating: true,
          backgroundColor: Colors.transparent,
          expandedHeight: 300,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40))),
          flexibleSpace: FlexibleSpaceBar(
            background: ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
              child: Image.asset(
                "assets/women.png",
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListView(
                children: cards,
              );
            },
            childCount: 1000, // 1000 list items
          ),
        ),
      ],
    ));
    // body: new Container(
    //     child: new ListView(
    //       children: cards,
    //     )
    // )
  }
}

class User {}

class CustomCard extends StatelessWidget {
  final String title;
  final String link;

  const CustomCard({this.title, this.link});
  // CustomCard({required this.title,required this.link});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
          builder: (_) => PDFViewerFromUrl(
            url: link,
          ),
        ),
      ),
      child: new Card(
        shadowColor: Colors.lightBlue,
        color: Colors.grey.shade400,
        elevation: 2,
        child: new Column(
          children: <Widget>[
            new Padding(
                padding: new EdgeInsets.all(7.0),
                child: new Padding(
                  padding: new EdgeInsets.all(7.0),
                  child: new Text(title, style: new TextStyle(fontSize: 18.0)),
                ))
          ],
        ),
      ),
    );
  }
}

class PDFViewerFromUrl extends StatelessWidget {
  const PDFViewerFromUrl({Key key, this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF From Url'),
        backgroundColor: new Color(0xFF673AB7),
      ),
      body: const PDF().fromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
