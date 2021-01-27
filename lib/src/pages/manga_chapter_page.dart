import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:manga_app/src/inherited/inherited_manga.dart';
import 'package:manga_app/src/models/manga_model.dart';

//final List<String> imgList = [];

class MangaChapter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final mangaChapter = ModalRoute.of(context).settings.arguments;
    final List<String> imgList = [
      'https://i.pinimg.com/originals/04/f5/8a/04f58afd7424a02a826eb74eddf98d91.jpg',
      'https://i.pinimg.com/originals/61/3b/b1/613bb1e4fe4cc594612aa6bac37da54b.jpg',
      'https://i.pinimg.com/736x/07/d9/af/07d9afe498db59b76bf4304c4e2998ab.jpg'
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(mangaChapter.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0)),
        backgroundColor: Colors.transparent
      ),
      body: FutureBuilder(
        future: InheritedManga.of(context).helper.getChapterImages('http://mangafox.icu/the-gamer-chapter-358'),
        builder: (BuildContext context, AsyncSnapshot<List<Manga>> snapshot) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
            ),
            items: imgList.map((item) => Container(
              child: Center(
                child: Image.network(item, fit: BoxFit.cover, height: height,)
              ),
            )).toList(),
          );
        },
      ),
    );
  }

  
  /*Widget build(BuildContext context) {

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
          Image.network(
            'https://xcdn-202.bato.to/00004/images/18/b3/18b36930c607535f688ed8d847252d32bcd73fca_302236_869_1247.jpg?acc=T6UKrqnuxxDjCIliFnVMyQ&exp=1611608877'
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
  }*/
}