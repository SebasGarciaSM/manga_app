import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;



class MangaInfoPage extends StatefulWidget {

  @override
  _MangaInfoPageState createState() => _MangaInfoPageState();
  
}

class _MangaInfoPageState extends State<MangaInfoPage> {

  String title;
  List<String> description = List();
  List<String> link = List();
  List<String> image;
  List<String> chapters = List();
  List<String> views = List(); 

  void getData() async {
    final response = await http.get('http://mangafox.icu/latest-manga/the-duchess-50-tea-recipes');
    dom.Document document = parser.parse(response.body);

    final titleElement  = document.getElementsByClassName('manga-info-pic');
    final imageElement  = document.getElementsByClassName('manga-info-pic');
    
    setState(() {

      title = titleElement
          .map((element) =>
      element.getElementsByTagName("h1")[1].innerHtml)
          .toString();

      image = imageElement
          .map((element) =>
      element.getElementsByTagName("img")[0].attributes['src'])
          .toList();
    });
  }

  @override
  // ignore: must_call_super
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    
    var manga = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(manga.toString().replaceAll('-', ' '), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),),
        backgroundColor: Colors.transparent
      ),
      body: Container(
      padding: EdgeInsets.symmetric(horizontal:20.0),
      child: ListView(
        
        children: <Widget>[
          Column(
          children: [
            Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      //image: NetworkImage(image),
                      image: NetworkImage(image.toString()),
                      height: 170.0,
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(manga.toString().replaceAll('-', ' '), style: Theme.of(context).textTheme.headline6, softWrap: true,),
                      Text('manga.authors', style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
                      Text('manga.status', style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
                      Text('manga.genres', style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            child: Icon(Icons.remove_red_eye_rounded)
                          ),
                          Text('manga.views', style: Theme.of(context).textTheme.subtitle1,)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              child: Text('When I opened my eyes I had become the duchess. But something isn’t right. I went as far as becoming a character but I’m just a duchess in name that gets mistreated by the maids and ignored by her husband. What a crappy life! Gosh, I don’t know what to do anymore. I’ll just quietly enjoy my tea, was what I thought. “Can you prepare tea for me again next time?” Something’s gone wrong with my cold husband!', textAlign: TextAlign.justify),
            ),
            SizedBox(height: 20.0),
            Container(
              child: Column(
                children: <Widget>[
                  Text('Chapters'.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold,)),
                  /*ListView.builder(
                    itemCount: 1,
                    itemBuilder:(BuildContext context, int index){
                      Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text('chapter title', style: TextStyle(fontWeight: FontWeight.bold)),
                          )
                        ],
                      )
                    );
                    }
                  )*/
                ],
              ),
            )
          ],
        ),
        ]
      ),
      
     ),
   );
  }
    
}