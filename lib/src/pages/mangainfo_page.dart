import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:manga_app/src/pages/home_page.dart';



class MangaInfoPage extends StatefulWidget {

  @override
  _MangaInfoPageState createState() => _MangaInfoPageState();
  
}

class _MangaInfoPageState extends State<MangaInfoPage> {

  List<String> title;
  List<String> author;
  List<String> status;
  List<String> genres;
  List<String> description;
  List<String> image;
  List<String> chapters = List();
  List<String> views = List();

  void getData(String manga) async {
    final response = await http.get('http://mangafox.icu/manga/$manga');
    dom.Document document = parser.parse(response.body);

    final titleElement  = document.getElementsByClassName('manga-info-text');
    final imageElement  = document.getElementsByClassName('manga-info-pic');
    final authorElement  = document.getElementsByClassName('manga-info-text');
    final statusElement  = document.getElementsByClassName('manga-info-text');
    final viewsElement  = document.getElementsByClassName('manga-info-text');
    //final genresElement  = document.getElementsByClassName('manga-info-text');
    final chaptersElement = document.getElementsByClassName('chapter_title');
    final descriptionElement = document.getElementsByClassName('leftCol');
    

    setState(() {
      title = titleElement
          .map((element) =>
      element.getElementsByTagName("h1")[0].innerHtml)
          .toList();

      image = imageElement
          .map((element) =>
      element.getElementsByTagName("img")[0].attributes['src'])
          .toList();
      
      author = authorElement
          .map((element) =>
      element.getElementsByTagName("li")[1].innerHtml)
          .toList();

      status = statusElement
          .map((element) =>
      element.getElementsByTagName("li")[2].innerHtml)
          .toList();

      views = viewsElement
          .map((element) =>
      element.getElementsByTagName("li")[5].innerHtml)
          .toList();

      description = descriptionElement
          .map((element) =>
      element.getElementsByTagName("div")[5].innerHtml)
          .toList();

      chapters = chaptersElement
          .map((element) =>
      element.innerHtml.toString())
          .toList();
    });
  }

  @override
  // ignore: must_call_super
  void initState() {
    //getData();
  }

  @override
  Widget build(BuildContext context) {
    
    var manga = ModalRoute.of(context).settings.arguments;
    getData(manga);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(manga.toString().replaceAll('[', '').replaceAll(']', ''), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0)),
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
                      image:  NetworkImage(image.toString().replaceAll('[', '').replaceAll(']', '')),
                      //image: NetworkImage('https://xcdn-000.animemark.com/acg_covers/W300/00/99/00997cd26ee88de738810ffd79577a2dbc7e9704_39786_200_270.jpg'),
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
                      Text(author.toString().replaceAll('[', '').replaceAll(']', ''), style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
                      Text(status.toString().replaceAll('[', '').replaceAll(']', ''), style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            child: Icon(Icons.remove_red_eye_rounded)
                          ),
                          Text(views.toString().replaceAll('[', '').replaceAll(']', ''), style: Theme.of(context).textTheme.subtitle1,)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              child: Text(description.toString().replaceAll('[', '').replaceAll(']', ''), textAlign: TextAlign.justify),
            ),
            SizedBox(height: 20.0),
            Container(
              child: Column(
                children: <Widget>[
                  Text('Chapters'.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold,)),
                  /*ListView.builder(
                    itemCount: chapters.length,
                    itemBuilder:(context, int index){
                      Container(
                      //padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(chapters[index].toString().replaceAll('[', '').replaceAll(']', ''), style: TextStyle(fontWeight: FontWeight.bold)),
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
                            onTap: (){},
                            //onTap: ()=>Navigator.pushNamed(context, 'mangainfo', arguments: title[index].replaceAll(' ', '-')),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                          /*child: GestureDetector(
                            onTap: ()=>Navigator.pushNamed(context, 'mangainfo', arguments: [index]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: card,
                            ),
                          ),*/
                        );
                    }
                  )*/
                ],
              ),
            )
          ],
        ),
        ]
      )     
     ),
   );
  }
}