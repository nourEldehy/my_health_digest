import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

List title=[];
List link=[];
int flag = 0;
//Creating a class user to store the data;

class Women extends StatefulWidget {
  @override
  _WomenState createState() => _WomenState();
}

class _WomenState extends State<Women> {
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
                  "assets/women.png",
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
    title=[];
    link=[];
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
          builder: (_) => PDFViewerFromAsset(
            pdfAssetPath: link,
            name: title,
          ),
        ),
      ),
      child: Card(
        shadowColor: Colors.grey ,
        color: Colors.teal[100 * (index % 9)],
        elevation: 4,
        margin: EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
        child: new Column(
          children: <Widget>[
            // Image.asset(link.replaceAll(".pdf", ".jpg")),
            new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Padding(
                  padding: new EdgeInsets.all(2.0),
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
        backgroundColor: Color.fromRGBO(33,208,195,1),
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
  String text;
  //replace your restFull API here.
  // String url = "http://10.0.2.2/api/pdfs/get-pdfs/en/women";
  // final response = await http.get(url);
  final loadedData = await rootBundle.loadString('assets/Women/women.txt');
  var responseData = loadedData;
  var response2 = responseData.toString().split(",");
  for (var i = 0; i < response2.length-1; i++) {

    var temp =  response2[i].split(": ");
    title.add(temp[0].replaceAll("{", ""));
    link.add(temp[1].replaceAll("}", ""));
  }
  flag=1;
}

class PDFViewerFromAsset extends StatelessWidget {
  PDFViewerFromAsset({Key key, this.pdfAssetPath, this.name}) : super(key: key);
  final String pdfAssetPath;
  final String name;
  final Completer<PDFViewController> _pdfViewController =
  Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
  StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Color.fromRGBO(33,208,195,1),
        actions: <Widget>[
          StreamBuilder<String>(
              stream: _pageCountController.stream,
              builder: (_, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(33,208,195,1),
                      ),
                      child: Text(snapshot.data),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ],
      ),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onPageChanged: (int current, int total) =>
            _pageCountController.add('${current + 1} - $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
          final int pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).fromAsset(
        pdfAssetPath,
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: '-',
                  backgroundColor: Color.fromRGBO(33,208,195,1),
                  child: const Text('-'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data;
                    final int currentPage =
                        (await pdfController.getCurrentPage()) - 1;
                    if (currentPage >= 0) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
                FloatingActionButton(
                  heroTag: '+',
                  backgroundColor: Color.fromRGBO(33,208,195,1),
                  child: const Text('+'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data;
                    final int currentPage =
                        (await pdfController.getCurrentPage()) + 1;
                    final int numberOfPages = await pdfController.getPageCount() ?? 0;
                    if (numberOfPages > currentPage) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}