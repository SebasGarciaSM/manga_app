import 'package:flutter/material.dart';
import 'package:manga_app/src/inherited/inherited_manga.dart';
import 'package:manga_app/src/models/manga_model.dart';
import 'package:manga_app/src/providers.dart/mangas_provider.dart';

class MangaDetails extends StatefulWidget {
  MangaDetails({Key key, this.authors}) : super(key: key);
  final String authors;
  @override
  _MangaDetailsState createState() => _MangaDetailsState();
}

class _MangaDetailsState extends State<MangaDetails> {
  @override
  Widget build(BuildContext context) {

    final Manga manga = ModalRoute.of(context).settings.arguments;

    final MangasProvider m = new MangasProvider();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(manga.title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0)),
        backgroundColor: Colors.transparent
      ),
      body: FutureBuilder<List<Manga>>(
        initialData: List<Manga>(),
        future: InheritedManga.of(context).helper.getMangaDetails(manga.url),
        builder: (BuildContext context, AsyncSnapshot<List<Manga>> snapshot){

        return Container(
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
                        image:  NetworkImage(manga.image),
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
                        Text(manga.title, style: Theme.of(context).textTheme.headline6, softWrap: true,),
                        //Text(manga.authors, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
                        //Text(status.toString().replaceAll('(', '').replaceAll(')', ''), style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
                        /*Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 5.0),
                              child: Icon(Icons.remove_red_eye_rounded)
                            ),
                            Text(manga, style: Theme.of(context).textTheme.subtitle1,)
                          ],
                        )*/
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                child: Text(manga.description, textAlign: TextAlign.justify),
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
     );
        }
      ),
   );
  }
}