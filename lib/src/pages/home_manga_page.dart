import 'package:flutter/material.dart';
import 'package:manga_app/src/inherited/inherited_manga.dart';
import 'package:manga_app/src/models/manga_model.dart';
import 'package:manga_app/src/providers/mangas_provider.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InheritedManga(
      helper: MangasProvider(),
      child: MaterialApp(
        title: 'Mangacan',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(title: 'Mangacan - Manga Reader'),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  
  HomePage({Key key, this.title, this.chapters, this.image}) : super(key: key);
  final String title;
  final String chapters;
  final String image;
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  final Manga manga = new Manga();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('MANGATOWN', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0)),
        centerTitle: false,
        backgroundColor: Colors.transparent
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Manga>>(
        initialData: List<Manga>(),
        future: InheritedManga.of(context).helper.getManga(),
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
                    //itemCount: 1,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, int index){
                      final card = Container(
                        child: Column(
                          children: <Widget>[
                            FadeInImage(
                              image: NetworkImage(snapshot.data[index].image),
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
                                    title: Text(snapshot.data[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                    /*subtitle: /*Text(snapshot.data[index].rating)*/
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(right: 5.0),
                                          child: Icon(Icons.star, color: Colors.amber,)
                                        ),
                                        Text('manga.rating[index]', style: TextStyle(fontWeight: FontWeight.bold),)
                                      ],
                                    ),*/
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
                        //onTap: (){},
                        onTap: ()=>Navigator.pushNamed(context, 'mangainfo', arguments: snapshot.data[index]),
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
    );
  }
}