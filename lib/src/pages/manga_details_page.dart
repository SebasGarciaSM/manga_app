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

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(manga.title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13.0)),
        backgroundColor: Colors.transparent
      ),
      body: FutureBuilder<Manga>(
        initialData: Manga(),
        future: InheritedManga.of(context).helper.getMangaDetails(manga.url),
        builder: (BuildContext context, AsyncSnapshot<Manga> snapshot){

        return Container(
        padding: EdgeInsets.symmetric(horizontal:20.0),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, int index){
            return Column(
            children: [
              Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        image:  NetworkImage(manga.image),
                        height: 170.0,
                        width: 115.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 15.0),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(manga.title, style: Theme.of(context).textTheme.headline6, softWrap: true,),
                        Text( snapshot.data.authors == null
                           ? 'Authors(s): '
                           : 'Authors(s): ${snapshot.data.authors.substring(1, snapshot.data.authors.length-1).trim()}'
                        ),
                        Text( snapshot.data.type == null
                           ? 'Type(s): '
                           : 'Type(s): ${snapshot.data.type.substring(1, snapshot.data.type.length-1).trim()}'
                        ),
                        Text( snapshot.data.status == null
                           ? 'Status(s): '
                           : 'Status(s): ${snapshot.data.status.substring(1, snapshot.data.status.length-1).trim()}'
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 5.0),
                              child: Icon(Icons.star, color: Colors.amber)
                            ),
                            Text(manga.rating)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                child: Text( 
                  snapshot.data.status == null
                  ? ''
                  : '${snapshot.data.description.substring(1, snapshot.data.description.length-1).replaceAll('<br>', '')}', textAlign: TextAlign.justify
                )
              ),
              SizedBox(height: 20.0),
              Container(
                child: Column(
                  children: <Widget>[
                    Text('Chapters'.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold,)),
                    FutureBuilder<List<Manga>>(
                      initialData: List<Manga>(),
                      future: InheritedManga.of(context).helper.getChapters(manga.url),
                      builder: (BuildContext context, AsyncSnapshot<List<Manga>> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return Center(
                                child: RefreshProgressIndicator(),
                              );
                            case ConnectionState.none:
                              return Center(
                                child: Text('No connection'),
                              );
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Data received incorrectly‎'),
                                );
                              }
                              return ListView.builder(
                                //scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, int index){
                                    final card = Container(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(3.0),
                                            child: Column(
                                              children: <Widget>[
                                                ListTile(
                                                  title: Text(snapshot.data[index].chapterTitle, style: TextStyle(fontWeight: FontWeight.bold)),
                                                )
                                              ],
                                            )
                                          )
                                        ],
                                      )
                                    );

                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
                                    //padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 3.0,
                                          spreadRadius: 0.1,
                                          offset: Offset(1.0, 2.0)
                                        )
                                      ]
                                    ),
                                    child: GestureDetector(
                                      onTap: ()=>Navigator.pushNamed(context, 'mangachapter', arguments: snapshot.data[index].chapterTitle),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0),
                                        child: card,
                                      )
                                    ),
                                  );
                                },
                              );
                          }
                        return Column();
                      },
                    )
                  ],
                ),
              )
            ],
          );
          })    
     );
        }
      ),
   );
  }
}