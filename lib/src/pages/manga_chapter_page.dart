import 'package:flutter/material.dart';
import 'package:manga_app/src/models/manga_model.dart';

class MangaChapter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final mangaChapter = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(mangaChapter.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0)),
        backgroundColor: Colors.transparent
      ),
      body: ListView(
        children: <Widget>[
          Image(
            image: NetworkImage('https://www.guiltybit.com/wp-content/uploads/2020/02/manga-Dragon-Ball-Super-58.jpg'),
          ),
          Image(
            image: NetworkImage('https://www.guiltybit.com/wp-content/uploads/2020/02/manga-Dragon-Ball-Super-58.jpg'),
          ),
          Image(
            image: NetworkImage('https://www.guiltybit.com/wp-content/uploads/2020/02/manga-Dragon-Ball-Super-58.jpg'),
          ),
          Image(
            image: NetworkImage('https://www.guiltybit.com/wp-content/uploads/2020/02/manga-Dragon-Ball-Super-58.jpg'),
          )
        ],
      ),
    );
  }
}