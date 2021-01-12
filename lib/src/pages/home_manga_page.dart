import 'package:flutter/material.dart';
import 'package:manga_app/src/models/manga_model.dart';
import 'package:manga_app/src/providers.dart/mangas_provider.dart';

class HomePage extends StatelessWidget {

  final mangaProvider = new MangasProvider();
  final MangaModel mangaModel = new MangaModel();

  @override
  Widget build(BuildContext context) {

    mangaProvider.getData();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('MANGAFOX', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0)),
        centerTitle: false,
        backgroundColor: Colors.transparent
      ),
      backgroundColor: Colors.white,
      body: mangaModel.title.length == 0
        ? Center(child: CircularProgressIndicator())
        : _listaMangas()
    );
  }

  Widget _listaMangas() {
    return ListView.builder(
        itemCount: mangaModel.title.length,
        itemBuilder: (context, int index){
          final card = Container(
            child: Column(
              children: <Widget>[
                FadeInImage(
                  image: NetworkImage(mangaModel.image[index]),
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
                        title: Text(mangaModel.title[index], style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(mangaModel.chapters[index]),
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
            onTap: ()=>Navigator.pushNamed(context, 'mangainfo', arguments: mangaModel.title[index].replaceAll(' ', '-')),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: card,
            )),
        );
      },
    );
  }
}