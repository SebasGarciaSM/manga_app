import 'package:flutter/material.dart';
//import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
//import 'package:url_launcher/url_launcher.dart';


class MyHomepage extends StatefulWidget {
  @override
  MyHomepageState createState() => MyHomepageState();

}

class MyHomepageState extends State<MyHomepage> {

  List<String> title = List();
  List<String> description = List();
  List<String> images = List();
  List<String> chapters = List();
  
  void _getData() async {
    final response = await http.get('http://mangafox.icu/latest-manga');
    dom.Document document = parser.parse(response.body);

    final elements      = document.getElementsByClassName('list-truyen-item-wrap');
    final element2      = document.getElementsByClassName('list-truyen-item-wrap');
    final imagesElement = document.getElementsByClassName('list-truyen-item-wrap');
    final chaptersElement = document.getElementsByClassName('list-truyen-item-wrap');

    setState(() {
      title = elements
          .map((element) =>
      element.getElementsByTagName("a")[0].attributes['title'])
          .toList();

      description = element2
          .map((element) =>
      element.getElementsByTagName("p")[0].innerHtml)
          .toList();

      images = imagesElement
          .map((element) =>
      element.getElementsByTagName("img")[0].attributes['src'])
          .toList();

      chapters = chaptersElement
          .map((element) =>
      element.getElementsByTagName("a")[2].innerHtml)
          .toList();
    });

    
  }
  
  @override
  // ignore: must_call_super
  void initState() {
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('MANGAFOX', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0)),
        centerTitle: false,
        backgroundColor: Colors.transparent
      ),
      backgroundColor: Colors.white,
      body: description.length == 0
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
          itemCount: description.length,
          itemBuilder: (context, int index){
            final card = Container(
              child: Column(
                children: <Widget>[
                  FadeInImage(
                    image: NetworkImage(images[index]),
                    placeholder: AssetImage('assets/Spinner-1s-201px.gif'),
                    fadeInDuration: Duration(milliseconds: 100),
                    height: 200.0,
                    fit: BoxFit.cover,
                    //width: double.infinity,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(title[index], style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(chapters[index]),
                        )
                        
                      ],
                    )
                  )
                ],
              )
             );

          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 7.0,
                  spreadRadius: 1.0,
                  offset: Offset(2.0, 8.0)
                )
              ]
            ),
            child: GestureDetector(
              onTap: ()=>Navigator.pushNamed(context, 'mangainfo', arguments: title[index].replaceAll(' ', '-')),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: card,
              )),
            /*child: GestureDetector(
              onTap: ()=>Navigator.pushNamed(context, 'mangainfo', arguments: [index]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: card,
              ),
            ),*/
          );
        },
      )
    );
  }


  Widget _tarjetaManga(BuildContext context, int index) {
    final card = Container(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(''),
            placeholder: AssetImage('assets/Spinner-1s-201px.gif'),
            fadeInDuration: Duration(milliseconds: 100),
            height: 250.0,
            fit: BoxFit.cover,
            //width: double.infinity,
          ),
          /*Image(
            image: NetworkImage(''),
          ),*/
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(title[index])
          )
        ],
      )
    );

    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 10.0)
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: card,
      ),
    );
  }
}
